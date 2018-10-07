//
//  ComicsListControllerConfig.swift
//  WallaMarvel
//
//  Created Mario Plaza on 6/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import UIKit

public struct ComicsListControllerConfig{
    public let preSelectedComicsIDs:[String]
    
    public init(preSelectedComicsIDs:[String] = []){
        self.preSelectedComicsIDs = preSelectedComicsIDs
    }
}

