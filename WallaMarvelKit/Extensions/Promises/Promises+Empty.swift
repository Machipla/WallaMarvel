//
//  Promises+Empty.swift
//  WallaMarvelKit
//
//  Created by Mario Chinchilla on 04/10/18.
//

import Foundation
import Promises

public typealias EmptyValuePromise = Promise<Void>

public extension Promise where Value == Void{
    convenience init(){
        self.init(())
    }
}
