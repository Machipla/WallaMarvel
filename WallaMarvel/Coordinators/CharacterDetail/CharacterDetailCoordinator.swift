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
    
    weak var delegate:CharacterDetailCoordinatorDelegate?
    private(set) weak var fromNavigationController:UINavigationController!
    private(set) weak var characterDetailController:CharacterDetailViewController?
    
    private let characterDetailControllerConfig:CharacterDetailControllerConfig
    
    init(fromNavigationController:UINavigationController, characterID:String){
        self.fromNavigationController = fromNavigationController
        self.characterDetailControllerConfig = .characterID(characterID)
    }
    
    init(fromNavigationController:UINavigationController, character:WallaMarvelAPI.Character){
        self.fromNavigationController = fromNavigationController
        self.characterDetailControllerConfig = .character(character)
    }
    
    func start(){
        let characterDetailController = CharacterDetailViewController(config: characterDetailControllerConfig)
        characterDetailController.delegate = self
        
        fromNavigationController.pushViewController(characterDetailController, animated: true)
        
        self.characterDetailController = characterDetailController
    }
}

extension CharacterDetailCoordinator: CharacterDetailViewControllerDelegate{
    func characterDetailViewControllerHasBeenDismised(_ controller:CharacterDetailViewController){
        delegate?.characterDetailCoordinatorHasFinished(self)
    }
}
