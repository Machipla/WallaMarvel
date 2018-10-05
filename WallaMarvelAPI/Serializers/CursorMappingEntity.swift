//
//  CursorMappingEntity.swift
//  WallaMarvelAPI
//
//  Created by Mario Plaza on 3/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import Foundation

/// A raw representation of a Cursor that comes from a JSON.
/// This is may be taken as a object representation of the JSON that can be converted into or feeded by an entity
internal struct CursorMappingEntity: Encodable, EntityConvertible{
    private let rawOffset:Int
    private let rawLimit:Int
    
    var asEntity:Cursor{
        return Cursor(offset: rawOffset, limit: rawLimit)
    }
    
    init(entity:Cursor) throws{
        rawOffset = entity.offset
        rawLimit = entity.limit
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: EncodingKeys.self)
        
        try container.encodeJSONValue(rawOffset, forKey: .offset)
        try container.encodeJSONValue(rawLimit, forKey: .limit)
    }
}

internal extension CursorMappingEntity{
    enum EncodingKeys: String, CodingKey{
        case offset
        case limit
    }
}
