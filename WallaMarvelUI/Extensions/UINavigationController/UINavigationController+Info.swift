//
//  UINavigationController+Info.swift
//  WallaMarvelUI
//
//  Created by Mario Plaza on 9/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import Foundation
import UIKit

public extension UINavigationController{
    /// Returns the root controller for this navigation controller
    var rootViewController:UIViewController?{ return viewControllers.first }
    /// Returns the fromController when this navigation contrller is making a transition. If no transition is on curse or the fromController couldn't be located
    /// it returns nil
    var onTransitionFromController:UIViewController?{ return transitionCoordinator?.viewController(forKey: .from) }
    /// True if a pop transition is on curse, otherwise false
    var isOnPopTransition:Bool{
        guard let fromController = onTransitionFromController else { return false }
        guard !viewControllers.contains(fromController) else { return false }
        
        return true
    }
}
