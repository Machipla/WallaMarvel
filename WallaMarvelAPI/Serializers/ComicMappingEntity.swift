//
//  ComicMappingEntity.swift
//  WallaMarvelAPI
//
//  Created by Mario Plaza on 3/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import Foundation
import SwiftDate

/// A raw representation of a Comic that may come from a JSON.
/// This is may be taken as a object representation of the JSON/Plist that can be converted into or feeded by an entity
internal struct ComicMappingEntity: Decodable, EntityConvertible{
    private let rawID:String
    private let rawTitle:String
    private let rawDescription:String
    private let rawModified:String
    private let rawThumbnail:[String:Any]
    
    var asEntity:Comic{
        return Comic(ID: rawID, title: rawTitle, description: rawDescription, modified: mappedModified, thumbnail: mappedThumbnail)
    }
    
    init(entity: Comic) throws{
        rawID = entity.ID
        rawTitle = entity.title
        rawDescription = entity.description
        rawModified = entity.modified.iso8601()
        rawThumbnail = try ThumbnailMappingEntity(entity: entity.thumbnail).asJSON()
        
    }
    
    init(from decoder:Decoder) throws{
        let container = try decoder.container(keyedBy: DecodingKeys.self)
        
        rawID           = try container.decodeMappedJSONValue(forKey: .ID)
        rawTitle        = try container.decodeMappedJSONValue(forKey: .title)
        rawDescription  = try container.decodeMappedJSONValue(forKey: .description)
        rawModified     = try container.decodeMappedJSONValue(forKey: .modified)
        rawThumbnail    = try container.decodeMappedJSONValue(forKey: .thumbnail)
        
        guard let _ = rawModified.date(format: .iso8601Auto)?.absoluteDate else { throw DecodingError.dataCorruptedError(forKey: .modified, in: container, debugDescription: "")}
        guard let _ = try? ThumbnailMappingEntity(from: rawThumbnail).asJSON() else { throw DecodingError.dataCorruptedError(forKey: .thumbnail, in: container, debugDescription: "")}
    }
}

extension ComicMappingEntity{
    enum DecodingKeys: String, CodingKey{
        case ID = "id"
        case title = "title"
        case description = "description"
        case modified = "modified"
        case thumbnail = "thumbnail"
    }
}

extension ComicMappingEntity{
    var mappedModified:Date{
        return rawModified.date(format: .iso8601Auto)!.absoluteDate
    }
    
    var mappedThumbnail:Thumbnail{
        return try! ThumbnailMappingEntity(from: rawThumbnail).asEntity
    }
}
