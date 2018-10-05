//
//  CharacterDetailWirer.swift
//  WallaMarvel
//
//  Created Mario Plaza on 4/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import UIKit

struct CharacterDetailWirer{
 
    static func wireUp(viewController:CharacterDetailViewController, config:CharacterDetailControllerConfig){
        let mediator = CharacterDetailMediator(config: config)
        let presenter = CharacterDetailPresenter()
        let delegateCaller = CharacterDetailDelegateCaller()
        
        viewController.mediator = mediator

        mediator.presenter = presenter
        mediator.delegateCaller = delegateCaller
        
        presenter.attachedView = viewController
        
        delegateCaller.attachedView = viewController
        
    }
    
    private init(){}
}
