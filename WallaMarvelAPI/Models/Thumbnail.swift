//
//  Thumbnail.swift
//  WallaMarvelAPI
//
//  Created by Mario Plaza on 2/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import Foundation

public struct Thumbnail{
    public let path:String
    public let `extension`:String
    public var url:URL{
        return URL(string: path+`extension`)!
    }
    
    public init?(path:String, extension:String){
        guard let _ = URL(string:path+`extension`) else { return nil }
        
        self.path = path
        self.extension = `extension`
    }
}
