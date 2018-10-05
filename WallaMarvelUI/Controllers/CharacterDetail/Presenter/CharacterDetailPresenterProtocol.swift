//
//  CharacterDetailPresenterProtocol.swift
//  WallaMarvel
//
//  Created Mario Plaza on 4/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import UIKit
import WallaMarvelAPI

protocol CharacterDetailPresenterProtocol: class{
    func display(_ character:WallaMarvelAPI.Character)
    func displayImageDetail(for character:WallaMarvelAPI.Character)
    
    func displayProgress()
    func hideProgress()
    func displayRefreshInProgress()
    func hideRefreshInProgress()
    func display(_ error:Error)
}
