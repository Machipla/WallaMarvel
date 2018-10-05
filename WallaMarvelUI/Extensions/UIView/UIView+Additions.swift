//
//  UIView+Additions.swift
//  WallaMarvelUI
//
//  Created by Mario Chinchilla on 05/10/18.
//

import Foundation
import UIKit

public extension UIView{
    public var isVisible:Bool       { return window != nil && !isHidden && isInstalled }
    public var isBeingAnimated:Bool { return !(layer.animationKeys()?.isEmpty ?? true) }
    public var isInstalled:Bool     { return superview != nil }
}
