//
//  String+Info.swift
//  WallaMarvelKit
//
//  Created by Mario Plaza on 5/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import Foundation

public extension String{
    var isURL:Bool{
        return URL(string: self) != nil
    }
}
