//
//  UIViewController+Info.swift
//  WallaMarvelUI
//
//  Created by Mario Chinchilla on 9/10/18.
//

import Foundation

public extension UIViewController{
    var isPresentingModal:Bool { return presentedViewController  != nil }
    var isModallyPresented:Bool{ return presentingViewController != nil }
    var isPushed:Bool  { return parent != nil }
    var isVisible:Bool { return isViewLoaded && view.isVisible }
    var canPresentController:Bool{ return isVisible && !isPresentingModal && !isBeingPresented && !isBeingDismissed && !isMovingToParent && !isMovingFromParent }
    var isOnTransition:Bool { return transitionCoordinator != nil }
}
