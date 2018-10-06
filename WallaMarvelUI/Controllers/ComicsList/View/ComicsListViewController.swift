//
//  ComicsListViewController.swift
//  WallaMarvel
//
//  Created Mario Plaza on 6/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import UIKit
import Eureka
import UIScrollView_InfiniteScroll

public final class ComicsListViewController: FormViewController {

    public weak var delegate:ComicsListViewControllerDelegate?
	var mediator: ComicsListMediatorProtocol!

    private var comicsSection:Section{ return form.allSections.first! }
    private var isEmptyResultsViewAlreadySetup:Bool{ return tableView.backgroundView is EmptyListView }
    
    public required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder) }
    public init(config:ComicsListControllerConfig){
        super.init(nibName: type(of: self).loadNibName, bundle: type(of: self).loadBundle)
        ComicsListWirer.wireUp(viewController: self, config: config)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "COMICS_LIST_TITLE".localized(onBundleFor: self)

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
private extension ComicsListViewController{
    func setupSearchBar(){
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        searchController.searchBar.enablesReturnKeyAutomatically = false
        searchController.searchBar.placeholder = "COMICS_LIST_SEARCH_PLACEHOLDER".localized(onBundleFor: self)
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        navigationItem.searchingController = searchController
    }
    
    func showNoResultsView(if condition:Bool){
        if condition && !isEmptyResultsViewAlreadySetup{
            let noResultsView = EmptyListView.fromNib()
            noResultsView?.titleLabel.text = "COMICS_LIST_NO_RESULTS_TITLE".localized(onBundleFor: self)
            noResultsView?.titleLabel.font = ComicsListViewController.Appearance.noFoundItemsTitleFont.scaledFontDynamicallyIfPossible(for: .title2)
            tableView.backgroundView = noResultsView
        }else if !condition{
            tableView.backgroundView = nil
        }
    }
}

// MARK: - IBAction's
private extension ComicsListViewController{
    @objc func refreshTriggered(){
        mediator.refreshTriggered()
    }
    
    func nextDataRequestTriggered(){
        mediator.nextDataRequestTriggered()
    }
}

// MARK - ComicsListViewProtocol conformance
extension ComicsListViewController:  ComicsListViewProtocol{
    func displayComicsData(_ displayData:ComicsListDisplayData, behavior:ComicsDisplayBehavior){
        func mapComicDisplayDataToRow(_ comicDisplayData:ComicsListDisplayData.SingleComicDisplay) -> BaseRow{
            return LabelRow(){ row in
                row.title = comicDisplayData.title

                if #available(iOS 11.0, *){ row.cell.textLabel?.adjustsFontForContentSizeCategory = true}
            }.onCellSelection{ _, row in
                guard let index = row.indexPath?.row else { return }
                self.mediator.comicSelected(at: index)
            }
        }
        
        if behavior == .removingOldOnes{
            comicsSection.removeAll()
        }
        
        let rows = displayData.comics.map(mapComicDisplayDataToRow(_:))
        comicsSection.append(contentsOf: rows)
        
        showNoResultsView(if: comicsSection.isEmpty)
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
extension ComicsListViewController: UISearchBarDelegate{
    public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        mediator.searchHasChanged(to: searchBar.text)
    }
    
    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        mediator.searchHasChanged(to: searchBar.text)
    }
}
