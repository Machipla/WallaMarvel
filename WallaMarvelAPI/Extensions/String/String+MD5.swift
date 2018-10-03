//
//  String+MD5.swift
//  WallaMarvelAPI
//
//  Created by Mario Plaza on 3/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import Foundation
import CommonCrypto

internal extension String{
    var MD5:String {
        let messageData = self.data(using:.utf8)!
        var digestData = Data(count: Int(CC_MD5_DIGEST_LENGTH))
        
        _ = digestData.withUnsafeMutableBytes {digestBytes in
            messageData.withUnsafeBytes {messageBytes in
                CC_MD5(messageBytes, CC_LONG(messageData.count), digestBytes)
            }
        }
        
        return digestData.map { String(format: "%02hhx", $0) }.joined()
    }
}
