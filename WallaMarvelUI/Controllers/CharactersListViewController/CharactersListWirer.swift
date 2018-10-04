//
//  CharactersListWirer.swift
//  WallaMarvel
//
//  Created Mario Plaza on 3/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import UIKit

struct CharactersListWirer{
 
    static func wireUp(viewController:CharactersListViewController){
        let mediator = CharactersListMediator()
        let presenter = CharactersListPresenter()
        let delegateCaller = CharactersListDelegateCaller()
        
        viewController.mediator = mediator
        
        mediator.presenter = presenter
        mediator.delegateCaller = delegateCaller
        
        presenter.attachedView = viewController
        
        delegateCaller.attachedView = viewController
        
    }
    
    private init(){}
}
