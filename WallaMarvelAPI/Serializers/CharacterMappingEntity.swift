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
    private let rawDescription:String?
    private let rawModified:String?
    private let rawThumbnail:[String:Any]?
    private let rawComicsData:[String:Any]?

    var asEntity:Character{
        return Character(ID: rawID, name: rawName, description: rawDescription, modified: mappedModified, thumbnail: mappedThumbnail, comicsData: mappedComicsData)
    }
    
    init(entity: Character) throws{
        rawID = entity.ID
        rawName = entity.name
        rawDescription = entity.description
        rawModified = entity.modified?.iso8601()
        
        if let thumbnail = entity.thumbnail{
            rawThumbnail = try ThumbnailMappingEntity(entity: thumbnail).asJSON()
        }else{
            rawThumbnail = nil
        }
        
        if let comicsData = entity.comicsData{
            rawComicsData = try ComicsDataMappingEntity(entity: comicsData).asJSON()
        }else{
            rawComicsData = nil
        }
    }

    init(from decoder:Decoder) throws{
        let container = try decoder.container(keyedBy: DecodingKeys.self)

        rawID           = try container.decodeMappedJSONValue(forKey: .ID)
        rawName         = try container.decodeMappedJSONValue(forKey: .name)
        rawDescription  = try container.decodeMappedJSONValueIfPresent(forKey: .description)
        rawModified     = try container.decodeMappedJSONValueIfPresent(forKey: .modified)
        rawThumbnail    = try container.decodeMappedJSONValueIfPresent(forKey: .thumbnail)
        rawComicsData   = try container.decodeMappedJSONValueIfPresent(forKey: .comics)

        if let rawModified = rawModified, rawModified.date(format: .iso8601Auto)?.absoluteDate == nil{
            throw DecodingError.dataCorruptedError(forKey: .modified, in: container, debugDescription: "")
        }
        
        if let rawThumbnail = rawThumbnail, (try? ThumbnailMappingEntity(from: rawThumbnail)) == nil{
            throw DecodingError.dataCorruptedError(forKey: .thumbnail, in: container, debugDescription: "")
        }
        
        if let rawComicsData = rawComicsData, (try? ComicsDataMappingEntity(from: rawComicsData)) == nil{
            throw DecodingError.dataCorruptedError(forKey: .comics, in: container, debugDescription: "")
        }
    }
}

extension CharacterMappingEntity{
    enum DecodingKeys: String, CodingKey{
        case ID = "id"
        case name
        case description
        case modified
        case thumbnail
        case comics
    }
}

extension CharacterMappingEntity{
    var mappedModified:Date?{
        guard let rawModified = rawModified else { return nil }
        return rawModified.date(format: .iso8601Auto)!.absoluteDate
    }

    var mappedThumbnail:Thumbnail?{
        guard let rawThumbnail = rawThumbnail else { return nil }
        return try! ThumbnailMappingEntity(from: rawThumbnail).asEntity
    }
    
    var mappedComicsData:ComicsData?{
        guard let rawComicsData = rawComicsData else { return nil }
        return try? ComicsDataMappingEntity(from: rawComicsData).asEntity
    }
}
