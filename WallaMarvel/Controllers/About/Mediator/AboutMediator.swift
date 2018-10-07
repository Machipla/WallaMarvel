//
//  AboutMediator.swift
//  WallaMarvel
//
//  Created Mario Plaza on 7/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import UIKit

final class AboutMediator {
    var presenter: AboutPresenterProtocol!
    var delegateCaller: AboutDelegateCallerProtocol!
}

extension AboutMediator: AboutMediatorProtocol{
    
}
