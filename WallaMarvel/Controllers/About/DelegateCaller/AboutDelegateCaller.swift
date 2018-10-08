//
//  AboutDelegateCaller.swift
//  WallaMarvel
//
//  Created Mario Plaza on 7/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import UIKit

final class AboutDelegateCaller{
    weak var attachedView: AboutViewController!
}

extension AboutDelegateCaller: AboutDelegateCallerProtocol {
    func callDelegateForDismissDone(){
        attachedView.delegate?.aboutViewControllerHasBeenDismissed(attachedView)
    }
    
    func callDelegateForURLWillBePresented(){
        guard let safariController = attachedView.safariController, let safariPresentation = attachedView.safariPresentation else { return }
        attachedView.delegate?.aboutViewController(attachedView, willPresentWebOn: safariController, completionHandler: safariPresentation)
    }
    
    func callDelegateForURLHasBeenDismissed(){
        guard let safariController = attachedView.safariController else { return }
        attachedView.delegate?.aboutViewController(attachedView, hasDismissedWebOn: safariController)
    }
}
