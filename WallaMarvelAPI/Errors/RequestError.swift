//
//  RequestError.swift
//  WallaMarvelAPI
//
//  Created by Mario Plaza on 3/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import Foundation

public enum RequestError: Error, CustomNSError{
    // The data obtained in a request response is not consistent and therefore, the process failed
    case responseNotConsistent
    
    public var errorCode: Int{
        switch self {
        case .responseNotConsistent: return 0
        }
    }
    
    public var errorUserInfo: [String : Any]{
        return [:]
    }
    
    public var errorDomain:String{
        return String(describing: self)
    }
}

