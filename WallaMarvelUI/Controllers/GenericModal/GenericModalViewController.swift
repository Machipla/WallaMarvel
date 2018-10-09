//
//  GenericModalViewController.swift
//  WallaMarvelUI
//
//  Created by Mario Plaza on 8/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import Foundation
import IBAnimatable

open class GenericModalViewController<PresentingControllerType: UIViewController>: AnimatableModalViewController{
    
    public weak var delegate:GenericModalViewControllerDelegate?
    public var containedController:PresentingControllerType{
        didSet{ updateContainedController() }
    }
    
    open override var childForStatusBarStyle: UIViewController?{ return containedController }
    open override var childForStatusBarHidden: UIViewController?{ return containedController }
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask{ return containedController.supportedInterfaceOrientations }
    open override var shouldAutorotate: Bool{ return containedController.shouldAutorotate }
    
    public required init?(coder aDecoder: NSCoder) {
        containedController = PresentingControllerType()
        super.init(coder: aDecoder)
    }
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        containedController = PresentingControllerType()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    public required init(controller:PresentingControllerType){
        containedController = controller
        super.init(nibName: nil, bundle: nil)
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        updateContainedController()
    }
    
    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if parent == nil{
            delegate?.genericModalViewControllerHasBeenDismissed(self)
        }
    }
    
    private func updateContainedController(){
        if let oldChildren = children.first{
            (try? dismissing(oldChildren))?.dismiss()
        }
        
        (try? presenting(containedController, on: view))?.present()
    }
}
