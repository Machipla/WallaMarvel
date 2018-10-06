//
//  CharactersFilterWirer.swift
//  WallaMarvel
//
//  Created Mario Plaza on 6/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import UIKit

struct CharactersFilterWirer{
 
    static func wireUp(viewController:CharactersFilterViewController, config:CharactersFilterControllerConfig){
        let mediator = CharactersFilterMediator(config: config)
        let presenter = CharactersFilterPresenter()
        let delegateCaller = CharactersFilterDelegateCaller()
        let dataProvider = CharactersFilterDataProvider()
        
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
