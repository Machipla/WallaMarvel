//
//  HeroesWirer.swift
//  WallaMarvel
//
//  Created Mario Plaza on 3/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import UIKit

struct HeroesWirer{
 
    static func wireUp(viewController:HeroesViewController){
        let mediator = HeroesMediator()
        let presenter = HeroesPresenter()
        let delegateCaller = HeroesDelegateCaller()
        
        viewController.mediator = mediator
        
        mediator.presenter = presenter
        mediator.delegateCaller = delegateCaller
        
        presenter.attachedView = viewController
        
        delegateCaller.attachedView = viewController
        
    }
    
    private init(){}
}
