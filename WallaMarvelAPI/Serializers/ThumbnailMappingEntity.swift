//
//  ThumbnailMappingEntity.swift
//  WallaMarvelAPI
//
//  Created by Mario Plaza on 3/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import Foundation

/// A raw representation of a Thumbnail that comes from a JSON.
/// This is may be taken as a object representation of the JSON that can be converted into or feeded by an entity
internal struct ThumbnailMappingEntity: Codable, EntityConvertible{
    private let rawPath:String
    private let rawExtension:String
    
    var asEntity:Thumbnail{
        return Thumbnail(path: rawPath, extension: rawExtension)!
    }
    
    init(entity:Thumbnail) throws{
        rawPath = entity.path
        rawExtension = entity.extension
    }
    
    init(from decoder:Decoder) throws{
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        rawPath = try container.decodeMappedJSONValue(forKey: .path)
        rawExtension = try container.decodeMappedJSONValue(forKey: .extension)
        
        guard let _ = Thumbnail(path: rawPath, extension: rawExtension) else { throw MappingError.dataNotConsistent }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(rawPath, forKey: .path)
        try container.encode(rawExtension, forKey: .extension)
    }
}

internal extension ThumbnailMappingEntity{
    enum CodingKeys: String, CodingKey{
        case path
        case `extension`
    }
}
