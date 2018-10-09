//
//  UINavigationController+Transitions.swift
//  WallaMarvelUI
//
//  Created by Mario Chinchilla on 9/10/18.
//

import Foundation

public extension UINavigationController{
    func pushViewController(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        pushViewController(viewController, animated: animated)
        handleTransition(animated: animated, completion: completion)
    }
    
    func popViewController(animated: Bool, completion: (() -> Void)?){
        popViewController(animated: animated)
        handleTransition(animated: animated, completion: completion)
    }
    
    func popToViewController(_ viewController:UIViewController, animated: Bool, completion: (() -> Void)?){
        popToViewController(viewController, animated: animated)
        handleTransition(animated: animated, completion: completion)
    }
    
    func popToRootViewController(animated:Bool, completion:(() -> Void)?){
        popToRootViewController(animated: animated)
        handleTransition(animated: animated, completion: completion)
    }
}

private extension UINavigationController{
    func handleTransition(animated:Bool, completion:(() -> Void)?){
        guard animated, let coordinator = transitionCoordinator else{
            completion?()
            return
        }
        
        coordinator.animate(alongsideTransition: nil) { _ in completion?() }
    }
}
