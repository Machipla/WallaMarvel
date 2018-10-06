//
//  CharacterFiltersDataProviderProtocol.swift
//  WallaMarvelUI
//
//  Created by Mario Plaza on 6/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import Foundation
import WallaMarvelAPI

protocol CharacterFiltersDataProviderProtocol {
    func provideData() -> CharactersFilter
}
