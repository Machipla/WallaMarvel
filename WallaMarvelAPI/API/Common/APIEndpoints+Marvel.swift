//
//  APIEndpoints+Marvel.swift
//  WallaMarvelAPI
//
//  Created by Mario Plaza on 3/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import Foundation

internal extension API.Endpoints{
    internal enum Marvel{
        static let root         = "https://gateway.marvel.com"
        static let characters   = API.Endpoints.Marvel.root + "/v1/public/characters"
    }
}
