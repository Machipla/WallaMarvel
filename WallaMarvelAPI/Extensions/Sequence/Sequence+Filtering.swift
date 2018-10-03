//
//  Sequence+Filtering.swift
//  WallaMarvelAPI
//
//  Created by Mario Plaza on 3/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import Foundation

public extension Sequence where Iterator.Element: OptionalType{
    public func filteringNils() -> [Iterator.Element.Wrapped]{
        return filter{ return $0.optionalValue != nil } as! [Iterator.Element.Wrapped]
    }
}
