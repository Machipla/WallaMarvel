//
//  CharactersFilter.swift
//  WallaMarvelAPI
//
//  Created by Mario Plaza on 3/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import Foundation

public struct CharactersFilter{
    let name:String
    let nameStartsWith:String
    let modifiedSince:Date
    let comicIDs:[Int]
    let orderBy:CharacterOrderBy
    
    // XXX: These will not be available at the moment, maybe in a near future.
    //    let series:[Int]
    //    let events:[Int]
    //    let stories:[Int]
}
