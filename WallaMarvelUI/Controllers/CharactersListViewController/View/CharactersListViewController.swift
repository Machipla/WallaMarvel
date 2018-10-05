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

public final class CharactersListViewController: FormViewController {

    public weak var delegate:CharactersListViewControllerDelegate?
	var mediator: CharactersListMediatorProtocol!
    
    private var charactersSection:Section{ return form.allSections.first! }

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

    private func setupSearchBar(){
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        searchController.searchBar.enablesReturnKeyAutomatically = false
        searchController.searchBar.placeholder = "CHARACTERS_LIST_SEARCH_PLACEHOLDER".localized(onBundleFor: self)
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        navigationItem.searchingController = searchController
    }
}

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

extension UIFont{
    @available(iOS 11.0, *)
    func getScaledFont(for textStyle: UIFont.TextStyle) -> UIFont {
        
        /// Uncomment the code below to check all the available fonts and have them printed in the console to double check the font name with existing fonts 😉
        
        /*for family: String in UIFont.familyNames
         {
         print("\(family)")
         for names: String in UIFont.fontNames(forFamilyName: family)
         {
         print("== \(names)")
         }
         }*/
        
        let userFont =  UIFontDescriptor.preferredFontDescriptor(withTextStyle: textStyle)
        guard let customFont = UIFont(name: fontName, size: userFont.pointSize) else { fatalError("") }
        return UIFontMetrics.default.scaledFont(for: customFont)
    }
}

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
            }.onCellSelection{ _, row in
                guard let index = row.indexPath?.row else { return }
                self.mediator.characterTapped(at: index)
            }
        }

        if behavior == .removingOldOnes{
            charactersSection.removeAll()
        }
        
        let rows = displayData.characters.map(mapCharacterDisplayDataToRow(_:))
        charactersSection.append(contentsOf: rows)
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
