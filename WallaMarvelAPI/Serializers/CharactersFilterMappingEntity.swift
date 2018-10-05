//
//  CharactersFilterMappingEntity.swift
//  WallaMarvelAPI
//
//  Created by Mario Plaza on 3/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import Foundation
import SwiftDate

/// A raw representation of a CharactersFilter that comes from a JSON.
/// This is may be taken as a object representation of the JSON that can be converted into or feeded by an entity
internal struct CharactersFilterMappingEntity: Encodable, EntityConvertible{
    let rawName:String?
    let rawNameStartsWith:String?
    let rawModifiedSince:String?
    let rawComicIDs:String
    let rawOrderBy:String
    
    var asEntity:CharactersFilter{
        return CharactersFilter(name: rawName, nameStartsWith: rawNameStartsWith, modifiedSince: mappedModifiedSince, comicIDs: mappedComicIDs, orderBy: mappedOrderBy)
    }
    
    init(entity:CharactersFilter) throws{
        rawName = entity.name
        rawNameStartsWith = entity.nameStartsWith
        rawModifiedSince = entity.modifiedSince?.iso8601()
        rawComicIDs = entity.comicIDs.map{ String($0) }.joined(separator: ",")
        rawOrderBy = entity.orderBy.rawValue
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: EncodingKeys.self)

        try container.encodeJSONValueIfPresent(rawNameStartsWith, forKey: .nameStartsWith)
        try container.encodeJSONValueIfPresent(rawModifiedSince, forKey: .modifiedSince)
        try container.encodeJSONValue(rawOrderBy, forKey: .orderBy)

        if !(rawName?.isEmpty ?? true){
            try container.encodeJSONValueIfPresent(rawName, forKey: .name)
        }
        
        if !rawComicIDs.isEmpty{
            try container.encodeJSONValue(rawComicIDs, forKey: .comics)
        }
    }
}

internal extension CharactersFilterMappingEntity{
    enum EncodingKeys: String, CodingKey{
        case name
        case nameStartsWith
        case modifiedSince
        case comics
        case orderBy
    }
}

internal extension CharactersFilterMappingEntity{
    var mappedComicIDs:[Int]{
        return rawComicIDs.split(separator: ",").map{ Int($0) }.filteringNils()
    }
    
    var mappedModifiedSince:Date?{
        return rawModifiedSince?.date(format: .iso8601Auto)!.absoluteDate
    }
    
    var mappedOrderBy:CharacterOrderBy{
        return CharacterOrderBy(rawValue: rawOrderBy)!
    }
}
