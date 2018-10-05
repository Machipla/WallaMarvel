//
//  ComicsData.swift
//  WallaMarvelAPI
//
//  Created by Mario Plaza on 5/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import Foundation

/// Represents the comic data result obtained from a request of, for example, a character detail
public struct ComicsData{
    public let available:Int?
    public let returned:Int?
    public let collectionURL:URL?
    public let comics:[Comic]
}
