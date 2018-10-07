//
//  CharactersFilter.swift
//  WallaMarvelAPI
//
//  Created by Mario Plaza on 3/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import Foundation

public struct CharactersFilter{
    public var name:String?
    public var nameStartsWith:String?
    public var modifiedSince:Date?
    public var comicIDs:[String]
    public var orderBy:CharacterOrderBy?
    // XXX: These will not be available at the moment, maybe in a near future.
    //    let series:[String]
    //    let events:[String]
    //    let stories:[String]
    
    public init(name:String? = nil,
                nameStartsWith:String? = nil,
                modifiedSince:Date? = nil,
                comicIDs:[String] = [],
                orderBy:CharacterOrderBy? = .ascendingByName){
        self.name = name
        self.nameStartsWith = nameStartsWith
        self.modifiedSince = modifiedSince
        self.comicIDs = comicIDs
        self.orderBy = orderBy
    } 
}
