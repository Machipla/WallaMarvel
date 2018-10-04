//
//  Collection+Info.swift
//  WallaMarvelKit
//
//  Created by Mario Plaza on 4/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import Foundation

public extension Collection{
    /// Gives the full range of the collection. Any index contained in the range is safe to be accessed via subscript.
    /// It's a 0-indexed range.
    public var fullRange:ClosedRange<Int>{
        return 0...count-1
    }
}
