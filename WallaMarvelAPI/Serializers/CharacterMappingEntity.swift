//
//  CharacterSerializer.swift
//  WallaMarvelAPI
//
//  Created by Mario Plaza on 2/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import Foundation
import SwiftDate

/// A raw representation of a Character that may come from a JSON.
/// This is may be taken as a object representation of the JSON/Plist that can be converted into or feeded by an entity
internal struct CharacterMappingEntity: Decodable, EntityConvertible{
    private let rawID:String
    private let rawName:String
    private let rawDescription:String
    private let rawModified:String
    private let rawThumbnail:[String:Any]

    var asEntity:Character{
        return Character(ID: rawID, name: rawName, description: rawDescription, modified: mappedModified, thumbnail: mappedThumbnail)
    }
    
    init(entity: Character) throws{
        rawID = entity.ID
        rawName = entity.name
        rawDescription = entity.description
        rawModified = entity.modified.iso8601()
        rawThumbnail = try ThumbnailMappingEntity(entity: entity.thumbnail).asJSON()
        
    }

    init(from decoder:Decoder) throws{
        let container = try decoder.container(keyedBy: DecodingKeys.self)

        rawID           = try container.decodeMappedJSONValue(forKey: .ID)
        rawName         = try container.decodeMappedJSONValue(forKey: .name)
        rawDescription  = try container.decodeMappedJSONValue(forKey: .description)
        rawModified     = try container.decodeMappedJSONValue(forKey: .modified)
        rawThumbnail    = try container.decodeMappedJSONValue(forKey: .thumbnail)
        
        guard let _ = rawModified.date(format: .iso8601Auto)?.absoluteDate else { throw DecodingError.dataCorruptedError(forKey: .modified, in: container, debugDescription: "")}
        guard let _ = try? ThumbnailMappingEntity(from: rawThumbnail).asJSON() else { throw DecodingError.dataCorruptedError(forKey: .thumbnail, in: container, debugDescription: "")}
    }
}

extension CharacterMappingEntity{
    enum DecodingKeys: String, CodingKey{
        case ID = "id"
        case name = "name"
        case description = "description"
        case modified = "modified"
        case thumbnail = "thumbnail"
    }
}

extension CharacterMappingEntity{
    var mappedModified:Date{
        return rawModified.date(format: .iso8601Auto)!.absoluteDate
    }

    var mappedThumbnail:Thumbnail{
        return try! ThumbnailMappingEntity(from: rawThumbnail).asEntity
    }
}
