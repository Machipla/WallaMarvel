//
//  Dictionary+Filtering.swift
//  WallaMarvelAPI
//
//  Created by Mario Chinchilla on 3/10/18.
//

import Foundation

public extension Dictionary where Value: OptionalType{
    func filteringNilValues() -> [Key:Value.Wrapped]{
        return filter{ return $0.value.optionalValue != nil } as! [Key:Value.Wrapped]
    }
}
