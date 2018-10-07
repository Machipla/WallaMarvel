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
        attachedView.delegate?.aboutViewControllerDelegateHasBeenDismissed(attachedView)
    }
}
