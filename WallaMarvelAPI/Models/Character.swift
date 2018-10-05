//
//  Character.swift
//  WallaMarvelAPI
//
//  Created by Mario Plaza on 2/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import Foundation

/// Struct that represents a Marvel character.
public struct Character{
    public let ID:String
    public let name:String
    public let description:String?
    public let modified:Date?
    public let thumbnail:Thumbnail?
    public let comicsData:ComicsData?
    
    public init(ID:String,
                name:String,
                description:String? = nil,
                modified:Date? = nil,
                thumbnail:Thumbnail? = nil,
                comicsData:ComicsData? = nil){
        self.ID = ID
        self.name = name
        self.description = description
        self.modified = modified
        self.thumbnail = thumbnail
        self.comicsData = comicsData
    }
}
