//
//  UIImage+Additions.swift
//  WallaMarvelUI
//
//  Created by Mario Plaza on 4/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import Foundation

public extension UIImage{
    convenience init?(named:String, inBundleOf classInstance:AnyObject){
        self.init(named: named, in: Bundle(for: type(of: classInstance)))
    }
    
    convenience init?(named:String, in bundle:Bundle?){
        self.init(named: named, in: bundle, compatibleWith: nil)
    }
}
