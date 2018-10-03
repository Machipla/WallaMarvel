//
//  ComicsFilterMappingEntity.swift
//  WallaMarvelAPI
//
//  Created by Mario Plaza on 3/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import Foundation

/// A raw representation of a ComicsFilter that comes from a JSON.
/// This is may be taken as a object representation of the JSON that can be converted into or feeded by an entity
internal struct ComicsFilterMappingEntity: Encodable, EntityConvertible{
    let rawTitle:String
    let rawOrderBy:String
    
    var asEntity:ComicsFilter{
        return ComicsFilter(title: rawTitle, orderBy: mappedOrderBy)
    }
    
    init(entity:ComicsFilter) throws{
        rawTitle = entity.title
        rawOrderBy = entity.orderBy.rawValue
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: EncodingKeys.self)
        
        try container.encode(rawTitle, forKey: .title)
        try container.encode(rawOrderBy, forKey: .orderBy)
    }
}

internal extension ComicsFilterMappingEntity{
    enum EncodingKeys: String, CodingKey{
        case title
        case orderBy
    }
}

internal extension ComicsFilterMappingEntity{
    var mappedOrderBy:ComicOrderBy{
        return ComicOrderBy(rawValue: rawOrderBy)!
    }
}
