//
//  URL+Info.swift
//  WallaMarvelKit
//
//  Created by Mario Plaza on 4/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import Foundation

public extension URL{
    public var isHTTPSScheme:Bool{
        return scheme?.contains("https") ?? false
    }
    
    public var asHTTPSURL:URL{
        guard !isHTTPSScheme else { return self }
        
        let rawSafeURL = absoluteString.replacingOccurrences(of: scheme ?? "", with: "https")
        return URL(string: rawSafeURL)!
    }
}
