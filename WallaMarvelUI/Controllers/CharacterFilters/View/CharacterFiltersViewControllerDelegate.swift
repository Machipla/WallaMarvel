//
//  CharacterFiltersPresenterViewControllerDelegate.swift
//  WallaMarvel
//
//  Created Mario Plaza on 6/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import UIKit
import WallaMarvelAPI

public protocol CharacterFiltersViewControllerDelegate: class {
    func characterFiltersViewControllerCancelled(_ controller:CharacterFiltersViewController)
    func characterFiltersViewController(_ controller:CharacterFiltersViewController, hasSelected newFilters:CharactersFilter)
}

public extension CharacterFiltersViewControllerDelegate{
    func characterFiltersViewControllerCancelled(_ controller:CharacterFiltersViewController){}
    func characterFiltersViewController(_ controller:CharacterFiltersViewController, hasSelected newFilters:CharactersFilter){}
}
