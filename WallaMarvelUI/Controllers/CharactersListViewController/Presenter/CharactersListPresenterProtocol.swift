//
//  CharactersListPresenterProtocol.swift
//  WallaMarvel
//
//  Created Mario Plaza on 3/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import UIKit
import WallaMarvelAPI

protocol CharactersListPresenterProtocol: class{
    func display(_ characters:[WallaMarvelAPI.Character])
    
    func displayProgress()
    func hideProgress()
    func display(_ error:Error)
}
