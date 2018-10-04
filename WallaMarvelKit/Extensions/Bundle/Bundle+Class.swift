//
//  Bundle+Class.swift
//  WallaMarvelKit
//
//  Created by Mario Plaza on 4/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import Foundation

public extension Bundle{
    public convenience init(forClassOfInstance instance:AnyObject){
        self.init(for: type(of: instance))
    }
}
