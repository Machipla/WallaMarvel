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
import WallaMarvelKit

public final class HeroesViewController: FormViewController {

    public weak var delegate:HeroesViewControllerDelegate?
	var mediator: HeroesMediatorProtocol!

    public required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder) }
    public init(){
        super.init(nibName: type(of: self).loadNibName, bundle: type(of: self).loadBundle)
        HeroesWirer.wireUp(viewController: self)
    }
    
	public override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "HEROES_LIST_TITLE".localized(onBundleFor: self)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_filters", inBundleOf: self)!, style: .plain, target: self, action: #selector(filtersTapped))
        
        mediator.reloadData()
    }

}

private extension HeroesViewController{
    @objc func filtersTapped(){
        mediator.filtersTapped()
    }
}

extension HeroesViewController: HeroesViewProtocol{
    func displayHeroesData(_ displayData:HeroesDisplayData){
        func mapHeroDisplayDataToRow(_ heroDisplayData:HeroesDisplayData.SingleHeroDisplay) -> BaseRow{
            return LabelRow(){ row in
                row.cellStyle = .subtitle
                row.title = heroDisplayData.title
                row.cell.imageView?.setImage(withURL: heroDisplayData.imageURL, imageTransition: .crossDissolve(0.4))
            }
        }
        
        let rows = displayData.characters.map(mapHeroDisplayDataToRow(_:))
        let section = Section()
        section.append(contentsOf: rows)
        
        form +++ section
    }
}
