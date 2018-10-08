//
//  AboutCoordinator.swift
//  WallaMarvel
//
//  Created by Mario Plaza on 7/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import Foundation
import UIKit
import SafariServices
import IBAnimatable
import WallaMarvelAPI
import WallaMarvelUI

final class AboutCoordinator: Coordinator, Startable{
    var childs = [Coordinator]()
    
    weak var delegate:AboutCoordinatorDelegate?
    private(set) weak var fromController:UIViewController!
    private(set) weak var aboutController:AboutViewController?
    private weak var modalController:AnimatableModalViewController?
    
    init(fromController:UIViewController){
        self.fromController = fromController
    }
    
    func start(){
        let aboutController = AboutViewController()
        aboutController.delegate = self
        aboutController.definesPresentationContext = true
        
        let modalController = GenericModalViewController<AboutViewController>(controller: aboutController)
        modalController.delegate = self
        modalController.cornerRadius = 12
        modalController.modalPosition = .bottomCenter
        modalController.modalSize = (.full,.half)
        modalController.dismissOnTap = true

        fromController.present(modalController, animated: true, completion: nil)
        self.aboutController = aboutController
        self.modalController = modalController
    }
}

extension AboutCoordinator: AboutViewControllerDelegate{
    func aboutViewController(_ controller: AboutViewController, willPresentWebOn safariController: SFSafariViewController, completionHandler:@escaping (() -> Void)) {
        safariController.modalPresentationStyle = .overCurrentContext
        safariController.modalTransitionStyle = .crossDissolve
        safariController.modalPresentationCapturesStatusBarAppearance = true
        
        modalController?.modalSize = (.full,.full)
        modalController?.presentationController?.containerView?.setNeedsLayout()

        UIView.animate(withDuration: 0.4){
            self.modalController?.presentationController?.containerView?.layoutIfNeeded()
            completionHandler()
        }
    }

    func aboutViewController(_ controller: AboutViewController, hasDismissedWebOn safariController: SFSafariViewController) {
        modalController?.modalSize = (.full,.half)
        modalController?.presentationController?.containerView?.setNeedsLayout()

        UIView.animate(withDuration: 0.4){
            self.modalController?.presentationController?.containerView?.layoutIfNeeded()
        }
    }
}

extension AboutCoordinator: GenericModalViewControllerDelegate{
    func genericModalViewControllerHasBeenDismissed<PresentingControllerType>(_ controller: GenericModalViewController<PresentingControllerType>)
        where PresentingControllerType : UIViewController {
        delegate?.aboutCoordinatorHasFinished(self)
    }
}
