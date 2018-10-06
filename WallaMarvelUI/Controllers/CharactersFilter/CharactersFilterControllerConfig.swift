//
//  CharactersFiltersControllerConfig.swift
//  WallaMarvel
//
//  Created Mario Plaza on 6/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import UIKit
import WallaMarvelAPI

public struct CharactersFilterControllerConfig{
    public let preSelectedFilters:CharactersFilter?
    
    public init(preSelectedFilters:CharactersFilter?){
        self.preSelectedFilters = preSelectedFilters
    }
}

