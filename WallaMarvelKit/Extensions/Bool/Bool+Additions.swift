//
//  Bool+Additions.swift
//  WallaMarvelAPI
//
//  Created by Mario Plaza on 2/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import Foundation

public extension Bool{
    init<T: BinaryInteger>(_ num: T) {
        self.init(num != 0)
    }
}
