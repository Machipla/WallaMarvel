//
//  HeroesViewController.swift
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
        
        title = "HEROES_LIST_TITLE".localized(onBundleFor: self)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_filters", inBundleOf: self)!, style: .plain, target: self, action: #selector(filtersTapped))
        
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

extension CharactersListViewController: CharactersListViewProtocol{
    func displayHeroesData(_ displayData:CharactersDisplayData, behavior:CharactersDisplayBehavior){
        func mapHeroDisplayDataToRow(_ heroDisplayData:CharactersDisplayData.SingleCharacterDisplay) -> BaseRow{
            return CharacterRow(){ row in
                row.title = heroDisplayData.title
                row.imageURL = heroDisplayData.imageURL
            }
        }

        if behavior == .removingOldOnes{
            charactersSection.removeAll()
        }
        
        let rows = displayData.characters.map(mapHeroDisplayDataToRow(_:))
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