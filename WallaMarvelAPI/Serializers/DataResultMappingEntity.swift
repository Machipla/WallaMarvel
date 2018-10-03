//
//  DataResultMappingEntity.swift
//  WallaMarvelAPI
//
//  Created by Mario Plaza on 3/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import Foundation

/// A raw representation of a DataResult that may come from a JSON.
/// This is may be taken as a object representation of the JSON/Plist that can be converted into or feeded by an entity
internal struct DataResultMappingEntity: Decodable, EntityConvertible{
    private let rawOffset:Int
    private let rawLimit:Int
    private let rawTotal:Int
    private let rawCount:Int
    private let rawResults:[[String:Any]]
    
    var asEntity:DataResult{
        return DataResult(offset: rawOffset, limit: rawLimit, total: rawTotal, count: rawCount, results: rawResults)
    }
    
    init(entity: DataResult) throws{
        rawOffset = entity.offset
        rawLimit = entity.limit
        rawTotal = entity.total
        rawCount = entity.count
        rawResults = entity.results
    }
    
    init(from decoder:Decoder) throws{
        let container = try decoder.container(keyedBy: DecodingKeys.self)
        
        rawOffset   = try container.decodeMappedJSONValue(forKey: .offset)
        rawLimit    = try container.decodeMappedJSONValue(forKey: .limit)
        rawTotal    = try container.decodeMappedJSONValue(forKey: .total)
        rawCount    = try container.decodeMappedJSONValue(forKey: .count)
        rawResults  = try container.decodeMappedJSONValue(forKey: .results)
    }
}

extension DataResultMappingEntity{
    enum DecodingKeys: String, CodingKey{
        case offset
        case limit
        case total
        case count
        case results
    }
}
