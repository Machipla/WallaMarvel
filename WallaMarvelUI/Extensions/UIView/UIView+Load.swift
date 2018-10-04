//
//  UIView+Load.swift
//  WallaMarvelUI
//
//  Created by Mario Plaza on 4/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import Foundation

public extension UIView {
    class var nibName: String {
        return "\(self)".components(separatedBy: ".").first ?? ""
    }
    
    class var nib: UINib? {
        let bundle = Bundle(for: self)
        if let _ = bundle.path(forResource: nibName, ofType: "nib") {
            return UINib(nibName: nibName, bundle: bundle)
        } else {
            return nil
        }
    }
}
