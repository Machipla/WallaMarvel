//
//  CharacterDetailCoordinatorDelegate.swift
//  WallaMarvel
//
//  Created by Mario Plaza on 7/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import Foundation

protocol CharacterDetailCoordinatorDelegate: class{
    func characterDetailCoordinatorHasFinished(_ coordinator:CharacterDetailCoordinator)
}

extension CharacterDetailCoordinatorDelegate{
    func characterDetailCoordinatorHasFinished(_ coordinator:CharacterDetailCoordinator){}
}
