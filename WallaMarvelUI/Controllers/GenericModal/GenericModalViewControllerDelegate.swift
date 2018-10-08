//
//  GenericModalViewControllerDelegate.swift
//  WallaMarvelUI
//
//  Created by Mario Plaza on 8/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import Foundation

public protocol GenericModalViewControllerDelegate: class{
    func genericModalViewControllerHasBeenDismissed<PresentingControllerType: UIViewController>(_ controller:GenericModalViewController<PresentingControllerType>)
}

public extension GenericModalViewControllerDelegate{
    func genericModalViewControllerHasBeenDismissed<PresentingControllerType: UIViewController>(_ controller:GenericModalViewController<PresentingControllerType>){}
}
