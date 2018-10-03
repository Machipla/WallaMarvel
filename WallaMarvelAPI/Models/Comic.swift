//
//  Comic.swift
//  WallaMarvelAPI
//
//  Created by Mario Plaza on 3/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import Foundation

/// Struct that represents a Marvel comic
public struct Comic{
    public let ID:String
    public let title:String
    public let description:String
    public let modified:Date
    public let thumbnail:Thumbnail
}
