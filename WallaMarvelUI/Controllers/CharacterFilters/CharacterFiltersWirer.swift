//
//  CharacterFiltersWirer.swift
//  WallaMarvel
//
//  Created Mario Plaza on 6/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import UIKit

struct CharacterFiltersWirer{
 
    static func wireUp(viewController:CharacterFiltersViewController, config:CharacterFiltersControllerConfig){
        let mediator = CharacterFiltersMediator(config: config)
        let presenter = CharacterFiltersPresenter()
        let delegateCaller = CharacterFiltersDelegateCaller()
        let dataProvider = CharacterFiltersDataProvider()
        
        viewController.mediator = mediator
        
        mediator.presenter = presenter
        mediator.delegateCaller = delegateCaller
        mediator.dataProvider = dataProvider
        
        presenter.attachedView = viewController
        
        delegateCaller.attachedView = viewController
        
        dataProvider.attachedView = viewController
        
    }
    
    private init(){}
}
