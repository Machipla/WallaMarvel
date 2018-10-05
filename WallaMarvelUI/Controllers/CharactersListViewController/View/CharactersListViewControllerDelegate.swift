//
//  HeroesPresenterViewControllerDelegate.swift
//  WallaMarvel
//
//  Created Mario Plaza on 3/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import UIKit
import WallaMarvelAPI

public protocol CharactersListViewControllerDelegate: class {
    func charactersListViewController(_ controller:CharactersListViewController, hasSelected character:WallaMarvelAPI.Character)
}

public extension CharactersListViewControllerDelegate {
    func charactersListViewController(_ controller:CharactersListViewController, hasSelected character:WallaMarvelAPI.Character){}
}
