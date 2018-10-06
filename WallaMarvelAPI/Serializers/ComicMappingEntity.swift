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
internal struct ComicMappingEntity: Codable, EntityConvertible{
    private let rawID:String?
    private let rawTitle:String
    private let rawDescription:String?
    private let rawModified:String?
    private let rawThumbnail:[String:Any]?
    
    var asEntity:Comic{
        return Comic(ID: rawID, title: rawTitle, description: rawDescription, modified: mappedModified, thumbnail: mappedThumbnail)
    }
    
    init(entity: Comic) throws{
        rawID = entity.ID
        rawTitle = entity.title
        rawDescription = entity.description
        rawModified = entity.modified?.iso8601()
        
        if let thumbnail = entity.thumbnail{
            rawThumbnail = try ThumbnailMappingEntity(entity: thumbnail).asJSON()
        }else{
            rawThumbnail = nil
        }
    }
    
    init(from decoder:Decoder) throws{
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        rawID           = try container.decodeMappedJSONValueIfPresent(forKey: .ID)
        rawDescription  = try container.decodeMappedJSONValueIfPresent(forKey: .description)
        rawModified     = try container.decodeMappedJSONValueIfPresent(forKey: .modified)
        rawThumbnail    = try container.decodeMappedJSONValueIfPresent(forKey: .thumbnail)
        
        // Sometimes, the JSON will set the comic name as "title" and sometimes it will call it "name".
        // Instead of making a new MappingEntity, we just handle it here. In the future if more field names are different we would make different serializers for the same model.
        if let title:String = try? container.decodeMappedJSONValue(forKey: .title){
            rawTitle = title
        }else if let name:String = try? container.decodeMappedJSONValue(forKey: .name){
            rawTitle = name
        }else{
            throw DecodingError.keyNotFound(CodingKeys.title, DecodingError.Context(codingPath: [], debugDescription: ""))
        }
        
        // We do check rawModified to be an ISO8601 date without SwiftDate as if malformed string comes in, SwiftDate throws an exception
        if let rawModified = rawModified, !rawModified.isISO8601Date{
            throw DecodingError.dataCorruptedError(forKey: .modified, in: container, debugDescription: "")
        }
        
        if let rawThumbnail = rawThumbnail, (try? ThumbnailMappingEntity(from: rawThumbnail)) == nil{
            throw DecodingError.dataCorruptedError(forKey: .thumbnail, in: container, debugDescription: "")
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encodeJSONValueIfPresent(rawID, forKey: .ID)
        try container.encodeJSONValue(rawTitle, forKey: .title)
        try container.encodeJSONValueIfPresent(rawDescription, forKey: .description)
        try container.encodeJSONValueIfPresent(rawModified, forKey: .modified)
        try container.encodeJSONValueIfPresent(rawThumbnail, forKey: .thumbnail)
    }
}

extension ComicMappingEntity{
    enum CodingKeys: String, CodingKey{
        case ID = "id"
        case title
        case name
        case description
        case modified
        case thumbnail
    }
}

extension ComicMappingEntity{
    var mappedModified:Date?{
        guard let rawModified = rawModified else { return nil }
        return rawModified.date(format: .iso8601Auto)!.absoluteDate
    }
    
    var mappedThumbnail:Thumbnail?{
        guard let rawThumbnail = rawThumbnail else { return nil }
        return try! ThumbnailMappingEntity(from: rawThumbnail).asEntity
    }
}
