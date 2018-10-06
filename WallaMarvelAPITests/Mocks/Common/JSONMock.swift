//
//  JSONMock.swift
//  WallaMarvelAPITests
//
//  Created by Mario Plaza on 6/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import Foundation
@testable import WallaMarvelAPI

protocol JSONMock{
    associatedtype FieldType: JSONField
    
    var JSON:[String:Any] {get set}
    
    /// Clears all the mock
    mutating func clearUp()
    
    /// Creates a mock that returns a valid JSON
    /// - Returns: The self instance with a valid JSON in it
    func creatingValid() -> Self
    
    /// Injects a value of a JSON type in the field specified
    /// - Parameter field: The field to fill with the value
    /// - Parameter value: The value to insert in the field
    /// - Returns: The self instance modified with the values
    func injecting(on field:FieldType, value:AnyJSONType) -> Self
    
    /// Clears up all the mock
    /// - Returns: The self instance, cleared up
    func clearingUp() -> Self
}

extension JSONMock{
    mutating func clearUp(){
        JSON.removeAll()
    }
    
    func injecting(on field:FieldType, value:AnyJSONType) -> Self{
        var injectedMock = self
        injectedMock.JSON[field.rawValue] = value.rawValue
        return injectedMock
    }
    
    func clearingUp() -> Self{
        var clearingMock = self
        clearingMock.clearUp()
        return clearingMock
    }
}
