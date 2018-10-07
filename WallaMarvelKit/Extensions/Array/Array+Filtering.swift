//
//  Array+Filtering.swift
//  WallaMarvelKit
//
//  Created by Mario Plaza on 6/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import Foundation

public extension Array where Element: Equatable{
    mutating func removeDuplicates(){
        var result = [Element]()
        forEach({ if !result.contains($0) { result.append($0) } })
        self = result
    }
    
    func removingDuplicates() -> [Element]{
        var toRemoveArray = self
        toRemoveArray.removeDuplicates()
        return toRemoveArray
    }
    
    mutating func remove(_ element: Element){
        if let indexOfObject:Int = index(of: element){
            remove(at: indexOfObject)
        }
    }
    
    func removing(_ element:Element) -> [Element]{
        var toRemoveArray = self
        toRemoveArray.remove(element)
        return toRemoveArray
    }
}
