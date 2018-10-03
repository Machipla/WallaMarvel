//
//  APIKeys+Marvel.swift
//  WallaMarvelAPI
//
//  Created by Mario Plaza on 3/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import Foundation

internal extension API.Keys{
    internal enum Marvel{
        static let Key = "f52808996c16e9d919a6464287fe3c7b"
        static let Secret = "0a8233e13b0a80cc4e5c007e1f830e8a0cb3d571"
        
        static func asParams(with timestamp:TimeInterval = Date().timeIntervalSinceNow) -> [String:Any]{
            let asStringTimestamp = String(timestamp)
            
            var marvelAPIKeysParams = [String:Any]()
            marvelAPIKeysParams["apikey"] = API.Keys.Marvel.Key
            marvelAPIKeysParams["ts"] = asStringTimestamp
            marvelAPIKeysParams["hash"] = (asStringTimestamp + API.Keys.Marvel.Secret + API.Keys.Marvel.Key).MD5
            
            return marvelAPIKeysParams
        }

    }
}
