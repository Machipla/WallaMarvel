//
//  CharacterDetailViewController.swift
//  WallaMarvel
//
//  Created Mario Plaza on 4/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import UIKit
import Eureka

public final class CharacterDetailViewController: FormViewController{

    public weak var delegate:CharacterDetailViewControllerDelegate?
	var mediator: CharacterDetailMediatorProtocol!

    private var characterSection:Section{ return form.allSections.first! }
    
    public required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder) }
    public init(config:CharacterDetailControllerConfig){
        super.init(nibName: type(of: self).loadNibName, bundle: type(of: self).loadBundle)
        CharacterDetailWirer.wireUp(viewController: self, config: config)
    }
    
	public override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "HERO_DETAIL_TITLE".localized(onBundleFor: self)
        
        form +++ Section()
        
        if #available(iOS 10.0, *){
            tableView.refreshControl = UIRefreshControl()
            tableView.refreshControl?.addTarget(self, action: #selector(refreshTriggered), for: .valueChanged)
        }
        
        mediator.reloadData()
    }

}

private extension CharacterDetailViewController{
    @objc func refreshTriggered(){
        mediator.refreshTriggered()
    }
}

extension CharacterDetailViewController:  CharacterDetailViewProtocol{
    func display(_ data:CharacterDetailDisplayData){
        1. Seguir por aquí, mostrando la info del personaje
        2. Luego seguir con la muestra de imagen
        3. Luego seguir con las demás tareas :)
    }
    
    func displayImage(with data:CharacterImageDetailDisplayData){
        
    }
    
    func drawRefreshProgressView() {
        guard #available(iOS 10.0, *) else { return }
        tableView.refreshControl?.beginRefreshing()
    }
    
    func hideRefreshProgressView() {
        guard #available(iOS 10.0, *) else { return }
        tableView.refreshControl?.endRefreshing()
    }
}
