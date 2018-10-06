//
//  CharactersFilterViewControllerDelegate.swift
//  WallaMarvel
//
//  Created Mario Plaza on 6/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import UIKit
import WallaMarvelAPI

public protocol CharactersFilterViewControllerDelegate: class {
    func characterFiltersViewControllerCancelled(_ controller:CharactersFilterViewController)
    func characterFiltersViewController(_ controller:CharactersFilterViewController, hasSelected newFilters:CharactersFilter)
}

public extension CharactersFilterViewControllerDelegate{
    func characterFiltersViewControllerCancelled(_ controller:CharactersFilterViewController){}
    func characterFiltersViewController(_ controller:CharactersFilterViewController, hasSelected newFilters:CharactersFilter){}
}
