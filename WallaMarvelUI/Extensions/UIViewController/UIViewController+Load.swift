//
//  UIViewController+Load.swift
//  WallaMarvelUI
//
//  Created by Mario Chinchilla on 03/10/18.
//

import Foundation

public extension UIViewController{
    class var loadNibName:String{ return String(describing: self) }
    class var loadBundle:Bundle{ return Bundle(for: self) }
}
