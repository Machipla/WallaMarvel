//
//  CharacterRequestParams.swift
//  WallaMarvelAPI
//
//  Created by Mario Plaza on 2/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import Foundation

public struct CharacterRequestParams{
    let name:String
    let nameStartsWith:String
    let modifiedSince:Date
    let comics:[Int]
    let orderBy:APICharacterOrderBy
    let limit:UInt
    let offset:UInt

    // XXX: These will not be available at the moment, maybe in a near future.
    //    let series:[Int]
    //    let events:[Int]
    //    let stories:[Int]
}
