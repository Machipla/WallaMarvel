//
//  EntityConvertible.swift
//  WallaMarvelAPI
//
//  Created by Mario Plaza on 2/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import Foundation

internal protocol EntityConvertible{
    associatedtype EntityType
    
    var asEntity:EntityType {get}
    
    init(entity: EntityType) throws
}
