//
//  ComicsListDelegateCallerProtocol.swift
//  WallaMarvel
//
//  Created Mario Plaza on 6/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import UIKit
import WallaMarvelAPI

protocol ComicsListDelegateCallerProtocol: class{
    func callDelegateForComicsSelected(_ comics:[Comic])
}
