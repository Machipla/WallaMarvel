//
//  ComicsListWirer.swift
//  WallaMarvel
//
//  Created Mario Plaza on 6/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import UIKit

struct ComicsListWirer{
 
    static func wireUp(viewController:ComicsListViewController, config:ComicsListControllerConfig){
        let mediator = ComicsListMediator(config: config)
        let presenter = ComicsListPresenter()
        let delegateCaller = ComicsListDelegateCaller()
        
        viewController.mediator = mediator
        
        mediator.presenter = presenter
        mediator.delegateCaller = delegateCaller
        
        presenter.attachedView = viewController
        
        delegateCaller.attachedView = viewController
        
    }
    
    private init(){}
}
