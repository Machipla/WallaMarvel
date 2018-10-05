//
//  ComicsDataMappingEntity.swift
//  WallaMarvelAPI
//
//  Created by Mario Plaza on 5/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import Foundation
import WallaMarvelKit

/// A raw representation of a ComicsData that may come from a JSON.
/// This is may be taken as a object representation of the JSON/Plist that can be converted into or feeded by an entity
internal struct ComicsDataMappingEntity: Codable, EntityConvertible{
    let rawAvailable:Int?
    let rawReturned:Int?
    let rawCollectionURL:String?
    let rawComics:[[String:Any]]
    
    var asEntity:ComicsData{
        return ComicsData(available: rawAvailable, returned: rawReturned, collectionURL: mappedCollectionURL, comics: mappedComics)
    }
    
    init(entity: ComicsData) throws{
        rawAvailable = entity.available
        rawReturned = entity.returned
        rawCollectionURL = entity.collectionURL?.absoluteString
        rawComics = entity.comics.map{ return try? ComicMappingEntity(entity: $0).asJSON() }.filteringNils()
    }
    
    init(from decoder:Decoder) throws{
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        rawAvailable        = try container.decodeMappedJSONValueIfPresent(forKey: .available)
        rawReturned         = try container.decodeMappedJSONValueIfPresent(forKey: .returned)
        rawCollectionURL    = try container.decodeMappedJSONValueIfPresent(forKey: .collectionURI)
        rawComics            = try container.decodeMappedJSONValue(forKey: .items)
        
        let collectionURLisURLOrNil = (rawCollectionURL?.isURL ?? false) || rawCollectionURL == nil
        guard collectionURLisURLOrNil else { throw DecodingError.dataCorruptedError(forKey: .collectionURI, in: container, debugDescription: "") }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encodeJSONValueIfPresent(rawAvailable, forKey: .available)
        try container.encodeJSONValueIfPresent(rawReturned, forKey: .returned)
        try container.encodeJSONValueIfPresent(rawCollectionURL, forKey: .collectionURI)
        try container.encodeJSONValue(rawComics, forKey: .items)
    }
}

extension ComicsDataMappingEntity{
    enum CodingKeys: String, CodingKey{
        case available
        case returned
        case collectionURI
        case items
    }
}

extension ComicsDataMappingEntity{
    var mappedCollectionURL:URL?{
        guard let rawCollectionURL = rawCollectionURL else { return nil }
        return URL(string: rawCollectionURL)!
    }
    
    var mappedComics:[Comic]{
        return rawComics.map{ return try? ComicMappingEntity(from: $0).asEntity }.filteringNils()
    }
}
