//
//  DataResult.swift
//  WallaMarvelAPI
//
//  Created by Mario Plaza on 3/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import Foundation

/// Represents the data result obtained from a request
internal struct DataResult{
    let offset:Int
    let limit:Int
    let total:Int
    let count:Int
    let results:[[String:Any]]
}
