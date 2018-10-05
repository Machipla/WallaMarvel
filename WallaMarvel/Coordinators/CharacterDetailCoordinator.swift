//
//  CharacterDetailCoordinator.swift
//  WallaMarvel
//
//  Created by Mario Plaza on 4/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import Foundation
import UIKit
import WallaMarvelAPI
import WallaMarvelUI

final class CharacterDetailCoordinator: Coordinator, Startable{
    var childs = [Coordinator]()
    
    private(set) weak var fromNavigationController:UINavigationController!
    private(set) weak var characterDetailController:CharacterDetailViewController?
    
    init(fromNavigationController:UINavigationController){
        self.fromNavigationController = fromNavigationController
    }
    
    func start(){
        let characterDetailControllerConfig = CharacterDetailControllerConfig.characterID("")
        let characterDetailController = CharacterDetailViewController(config: characterDetailControllerConfig)
        characterDetailController.delegate = self
        
        fromNavigationController.pushViewController(characterDetailController, animated: true)
        
        self.characterDetailController = characterDetailController
    }
}

extension CharacterDetailCoordinator: CharacterDetailViewControllerDelegate{
    
}
