//
//  MappingError.swift
//  WallaMarvelAPI
//
//  Created by Mario Plaza on 3/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import Foundation

public enum MappingError: Error, CustomNSError{
    // The data is not consistent and therefore, the mapping process failed
    case dataNotConsistent
    
    public var errorCode: Int{
        switch self {
        case .dataNotConsistent: return 0
        }
    }
    
    public var errorUserInfo: [String : Any]{
        return [:]
    }
    
    public var errorDomain:String{
        return String(describing: self)
    }
}

