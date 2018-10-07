//
//  AboutWirer.swift
//  WallaMarvel
//
//  Created Mario Plaza on 7/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import UIKit

struct AboutWirer{
 
    static func wireUp(viewController:AboutViewController){
        let mediator = AboutMediator()
        let presenter = AboutPresenter()
        let delegateCaller = AboutDelegateCaller()
        
        viewController.mediator = mediator

        mediator.presenter = presenter
        mediator.delegateCaller = delegateCaller
        
        presenter.attachedView = viewController
        
        delegateCaller.attachedView = viewController
        
    }
    
    private init(){}
}
