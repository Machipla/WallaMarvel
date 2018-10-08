//
//  AboutPresenterViewControllerDelegate.swift
//  WallaMarvel
//
//  Created Mario Plaza on 7/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import UIKit
import SafariServices

protocol AboutViewControllerDelegate: class {
    /// Warns the delegate that the controller has been dismissed
    /// - Parameter controller: The dismissed controller
    func aboutViewControllerHasBeenDismissed(_ controller:AboutViewController)
    
    /// Warns the delegate that the controller is about to show a web controller
    /// - Parameter controller: The controller that is about to show another controller
    /// - Parameter safariController: The presented web controller
    /// - Parameter completionHandler: A handler that must be called at the end of the delegate call. Animatable.
    func aboutViewController(_ controller:AboutViewController, willPresentWebOn safariController:SFSafariViewController, completionHandler:@escaping (() -> Void))
    
    /// Warns the delegate that the web controller has been dismissed
    /// - Parameter controller: The controller that presented the web controller
    /// - Parameter safariController: The dismissed web controller
    func aboutViewController(_ controller:AboutViewController, hasDismissedWebOn safariController:SFSafariViewController)
}

extension AboutViewControllerDelegate {
    func aboutViewControllerHasBeenDismissed(_ controller:AboutViewController){}
    func aboutViewController(_ controller:AboutViewController, hasDismissedWebOn safariController:SFSafariViewController){}
    
    func aboutViewController(_ controller:AboutViewController, willPresentWebOn safariController:SFSafariViewController, completionHandler:@escaping (() -> Void)){
        completionHandler()
    }
}
