//
//  AboutPresenterViewControllerDelegate.swift
//  WallaMarvel
//
//  Created Mario Plaza on 7/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import UIKit

protocol AboutViewControllerDelegate: class {
    func aboutViewControllerDelegateHasBeenDismissed(_ controller:AboutViewController)
}

extension AboutViewControllerDelegate {
    func aboutViewControllerDelegateHasBeenDismissed(_ controller:AboutViewController){}
}
