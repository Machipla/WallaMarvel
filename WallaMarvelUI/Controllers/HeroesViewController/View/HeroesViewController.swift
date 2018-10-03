//
//  HeroesViewController.swift
//  WallaMarvel
//
//  Created Mario Plaza on 3/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import UIKit
import Eureka

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
        mediator.reloadData()
    }

}

extension HeroesViewController:  HeroesViewProtocol{
    
}
