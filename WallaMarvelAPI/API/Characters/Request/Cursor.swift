//
//  Cursor.swift
//  WallaMarvelAPI
//
//  Created by Mario Plaza on 3/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import Foundation

// Helps to iterate through pages of items on Marvel API
public struct Cursor{
    // Skip the specified number of resources in the result set.
    public let offset:Int
    // Limit the result set to the specified number of resources.   
    public let limit:Int
    
    public init(offset:Int = 0, limit:Int = 20){
        self.offset = offset
        self.limit = limit
    }
    
    public mutating func resetToFirstResults(){
        self = Cursor()
    }
    
    public static func firstResults() -> Cursor{
        return Cursor()
    }
}
