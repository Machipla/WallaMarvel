//
//  Thumbnail.swift
//  WallaMarvelAPI
//
//  Created by Mario Plaza on 2/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import Foundation
import WallaMarvelKit

public struct Thumbnail{
    public let path:String
    public let `extension`:String
    
    /// URL of the thumbnail, already converted to secure http and ready to use
    public var url:URL{
        return URL(string: path+"."+`extension`)!.asHTTPSURL
    }
    
    public init?(path:String, extension:String){
        guard let _ = URL(string:path+`extension`) else { return nil }
        
        self.path = path
        self.extension = `extension`
    }
}
