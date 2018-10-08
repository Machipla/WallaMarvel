//
//  UIViewController+ChildInjection.swift
//  WallaMarvelUI
//
//  Created by Mario Chinchilla on 5/10/18.
//

import Foundation

public extension UIViewController{
    func presenting(_ childController:UIViewController, on containerView:UIView) throws -> ChildControllerPresentation{
        func pinChildView(_ childView:UIView, toEdgesOf containerView:UIView){
            let attributes:[NSLayoutConstraint.Attribute] = [.top,.bottom,.leading,.trailing]
            attributes.map{ return NSLayoutConstraint(item: containerView, attribute: $0, relatedBy: .equal, toItem: childView, attribute: $0, multiplier: 1, constant: 0) }.forEach{ $0.isActive = true}
            childView.translatesAutoresizingMaskIntoConstraints = false
        }
        
        return try ChildControllerPresentation(parentController: self, childController: childController, containerView: containerView, constraintHandler: pinChildView(_:toEdgesOf:))
    }
}

public extension UIViewController{
    enum ChildControllerAdditionError: Error{
        case containerViewNotInControllerHierarchy
    }
}

public extension UIViewController{
    public final class ChildControllerPresentation{
        public typealias AnimationsClosure = ((_ childView:UIView, _ containerView:UIView, _ completion:@escaping () -> Void) -> Void)
        public typealias ConstraintsClosure = ((_ childView:UIView, _ containerView:UIView) -> Void)
        
        public private(set) weak var parentController:UIViewController!
        public private(set) var childController:UIViewController
        public private(set) var containerView:UIView
        
        private var animations:AnimationsClosure?
        private var constraintHandler:ConstraintsClosure!
        
        public private(set) var hasStarted:Bool = false
        public var isAnimated:Bool{ return animations != nil }
        
        fileprivate init(parentController:UIViewController,
                         childController:UIViewController,
                         containerView:UIView,
                         animations:((UIView,UIView, () -> Void) -> Void)? = nil,
                         constraintHandler:@escaping ((UIView, UIView) -> Void)) throws {
            guard containerView.isDescendant(of: parentController.view) else { throw ChildControllerAdditionError.containerViewNotInControllerHierarchy }
            
            self.parentController = parentController
            self.childController = childController
            self.containerView = containerView
            
            self.animations = animations
            self.constraintHandler = constraintHandler
        }
        
        @discardableResult
        public func animating(by animations:@escaping AnimationsClosure) -> Self{
            self.animations = animations
            return self
        }
        
        @discardableResult
        public func constraining(to constraints:@escaping ConstraintsClosure) -> Self{
            constraintHandler = constraints
            return self
        }

        @discardableResult
        public func present(completion: (() -> Void)? = nil) -> Self{
            hasStarted = true
            
            childController.willMove(toParent: parentController)
            childController.beginAppearanceTransition(true, animated: isAnimated)
            parentController.addChild(childController)
            containerView.addSubview(childController.view)
            
            constraintHandler(childController.view,containerView)
            
            let finishHandler = {
                self.childController.didMove(toParent: self.parentController)
                self.hasStarted = false
                completion?()
            }
            
            if let animations = animations{
                animations(self.childController.view,self.containerView,finishHandler)
            }else{
                finishHandler()
            }
            
            return self
        }
    }
}
