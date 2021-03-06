//
//  CharactersFilterDelegateCallerProtocol.swift
//  WallaMarvel
//
//  Created Mario Plaza on 6/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import UIKit
import WallaMarvelAPI

protocol CharactersFilterDelegateCallerProtocol: class{
    func callDelegateForCancelTapped()
    func callDelegateForNewFiltersSelected(_ filters:CharactersFilter)
}
