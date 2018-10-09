//
//  CharactersViewController.swift
//  WallaMarvel
//
//  Created Mario Plaza on 3/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import UIKit
import Eureka
import AlamofireImage
import UIScrollView_InfiniteScroll
import WallaMarvelKit
import WallaMarvelAPI

public final class CharactersListViewController: FormViewController {

    public var searchController:UISearchController?{ return navigationItem.searchingController }
    public weak var delegate:CharactersListViewControllerDelegate?
    
	var mediator: CharactersListMediatorProtocol!
    
    internal var previewControllerToLaunch:UIViewController?
    private var rowsPrevieweingContexts = [UIViewControllerPreviewing]()
    
    private var charactersSection:Section{ return form.allSections.first! }
    private var isEmptyResultsViewAlreadySetup:Bool{ return tableView.backgroundView is EmptyListView }

    public required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder) }
    public init(){
        super.init(nibName: type(of: self).loadNibName, bundle: type(of: self).loadBundle)
        CharactersListWirer.wireUp(viewController: self)
    }
    
	public override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "CHARACTERS_LIST_TITLE".localized(onBundleFor: self)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_filters", inBundleOf: self)!, style: .plain, target: self, action: #selector(filtersTapped))
        setupSearchBar()
        
        tableView.addInfiniteScroll(handler: { _ in self.nextDataRequestTriggered() })
        form +++ Section()
        
        if #available(iOS 10.0, *){
            tableView.refreshControl = UIRefreshControl()
            tableView.refreshControl?.addTarget(self, action: #selector(refreshTriggered), for: .valueChanged)
        }
        
        mediator.reloadData()
    }
    
    public override func deleteAnimation(forRows rows: [BaseRow]) -> UITableView.RowAnimation { return .fade }
    public override func insertAnimation(forRows rows: [BaseRow]) -> UITableView.RowAnimation { return .fade }
    
}

// MARK: - Setup/Draw methods
private extension CharactersListViewController{
    func setupSearchBar(){
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        searchController.searchBar.enablesReturnKeyAutomatically = false
        searchController.searchBar.placeholder = "CHARACTERS_LIST_SEARCH_PLACEHOLDER".localized(onBundleFor: self)
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.delegate = self

        definesPresentationContext = true
        navigationItem.searchingController = searchController
    }
    
    func showNoResultsView(if condition:Bool){
        if condition && !isEmptyResultsViewAlreadySetup{
            let noResultsView = EmptyListView.fromNib()
            noResultsView?.titleLabel.text = "CHARACTERS_LIST_NO_RESULTS_TITLE".localized(onBundleFor: self)
            noResultsView?.titleLabel.font = CharactersListViewController.Appearance.noFoundItemsTitleFont.scaledFontDynamicallyIfPossible(for: .title2)
            tableView.backgroundView = noResultsView
        }else if !condition{
            tableView.backgroundView = nil
        }
    }
    
    func setupPreviewingForRows(){
        rowsPrevieweingContexts.forEach{ unregisterForPreviewing(withContext: $0) }
        
        if (navigationItem.searchingController?.isActive ?? false){
            charactersSection.forEach{ navigationItem.searchingController?.registerForPreviewing(with: self, sourceView: $0.baseCell) }
        }else{
            charactersSection.forEach{ registerForPreviewing(with: self, sourceView: $0.baseCell) }
        }
    }
}

// MARK: - IBAction's
private extension CharactersListViewController{
    @objc func filtersTapped(){
        mediator.filtersTapped()
    }
    
    @objc func refreshTriggered(){
        mediator.refreshTriggered()
    }
    
    func nextDataRequestTriggered(){
        mediator.nextDataRequestTriggered()
    }
}

// MARK - CharactersListViewProtocol conformance
extension CharactersListViewController: CharactersListViewProtocol{
    func displayCharactersData(_ displayData:CharactersDisplayData, behavior:CharactersDisplayBehavior){
        func mapCharacterDisplayDataToRow(_ characterDisplayData:CharactersDisplayData.SingleCharacterDisplay) -> BaseRow{
            return CharacterRow(){ row in
                row.title = characterDisplayData.title
                row.imageURL = characterDisplayData.imageURL
                row.cell.titleLabel.font = CharactersListViewController.Appearance.itemsFont.scaledFontDynamicallyIfPossible(for: .title3)
                
                if #available(iOS 11.0, *){ row.cell.titleLabel.adjustsFontForContentSizeCategory = true}
                
                switch CharactersListViewController.Appearance.itemsSeparatorStyle{
                case .color(let color):
                    row.cell.separatorView.backgroundColor = color
                case .gradient(let startColor, let endColor):
                    row.cell.separatorView.startColor = startColor
                    row.cell.separatorView.endColor = endColor
                }
                
                setupPreviewingForRows()
            }.onCellSelection{[weak self] _, row in
                guard let index = row.indexPath?.row else { return }
                self?.mediator.characterTapped(at: index)
            }
        }

        if behavior == .removingOldOnes{
            charactersSection.removeAll()
        }
        
        let rows = displayData.characters.map(mapCharacterDisplayDataToRow(_:))
        charactersSection.append(contentsOf: rows)
        
        showNoResultsView(if: charactersSection.isEmpty)
        setupPreviewingForRows()
    }
    
    func displayFiltersView(with preSelectedFilter:CharactersFilter){
        let config = CharactersFilterControllerConfig(preSelectedFilters: preSelectedFilter)
        let filtersController = CharactersFilterViewController(config: config)
        filtersController.delegate = self
        
        let navigationController = UINavigationController(rootViewController: filtersController)
        present(navigationController, animated: true, completion: nil)
    }
    
    func displaySearch(_ search:String?){
        navigationItem.searchingController?.searchBar.text = search
    }
    
    func drawRefreshProgressView() {
        guard #available(iOS 10.0, *) else { return }
        tableView.refreshControl?.beginRefreshing()
    }
    
    func hideRefreshProgressView() {
        guard #available(iOS 10.0, *) else { return }
        tableView.refreshControl?.endRefreshing()
    }
    
    func drawNextDataRequestProgressView(){
        tableView.beginInfiniteScroll(true)
    }
    
    func hideNextDataRequestProgressView(){
        tableView.finishInfiniteScroll()
    }
}

// MARK: - Delegates
extension CharactersListViewController: UISearchBarDelegate{
    public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        mediator.searchHasChanged(to: searchBar.text)
    }
    
    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        // We do it like this in order not to make a lot of requests at once if user types fast.
        // If we want to do it so, we just have to change the delegate method to the appropiate one
        mediator.searchHasChanged(to: searchBar.text)
    }
}

extension CharactersListViewController: UISearchControllerDelegate{
    public func didPresentSearchController(_ searchController: UISearchController) {
        setupPreviewingForRows()
    }
    
    public func didDismissSearchController(_ searchController: UISearchController) {
        setupPreviewingForRows()
    }
}

extension CharactersListViewController: CharactersFilterViewControllerDelegate{
    public func characterFiltersViewControllerCancelled(_ controller: CharactersFilterViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    public func characterFiltersViewController(_ controller: CharactersFilterViewController, hasSelected newFilters: CharactersFilter) {
        controller.dismiss(animated: true) {
            self.mediator.newFiltersSelected(newFilters)
        }
    }
}

extension CharactersListViewController: UIViewControllerPreviewingDelegate{
    public func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        guard let row = charactersSection.first(where: { $0.baseCell == previewingContext.sourceView }), let rowIndex = row.indexPath?.row else { return nil }
        mediator.previewSelectedForRow(at: rowIndex)
        
        let toLaunchController = previewControllerToLaunch
        previewControllerToLaunch = nil
        
        return toLaunchController
    }
    
    public func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        guard let row = charactersSection.first(where: { $0.baseCell == previewingContext.sourceView }), let rowIndex = row.indexPath?.row else { return }
        mediator.previewAcceptedForRow(at: rowIndex)
    }
}
