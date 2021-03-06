//
//  AboutDelegateCallerProtocol.swift
//  WallaMarvel
//
//  Created Mario Plaza on 7/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import UIKit

protocol AboutDelegateCallerProtocol: class{
    func callDelegateForDismissDone()
    func callDelegateForURLWillBePresented()
    func callDelegateForURLHasBeenDismissed()
}
