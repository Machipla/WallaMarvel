//
//  String+Format.swift
//  Pods
//
//  Created by Mario Chinchilla on 2/8/17.
//
//

import Foundation

public extension String{
    mutating func format(_ args:CVarArg...){
        self = String(format:self, arguments: args)
    }
    
    func formatted(_ args:CVarArg...) -> String{
        return String(format: self, arguments: args)
    }
}
