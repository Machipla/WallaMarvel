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
    func displayReloadCharacters(_ characters:[WallaMarvelAPI.Character])
    func displayRefreshCharacters(_ characters:[WallaMarvelAPI.Character])
    func displayNextDataCharacters(_ characters:[WallaMarvelAPI.Character])
    func displayFiltersView(with currentFilter:CharactersFilter)
    
    func displayProgress()
    func hideProgress()
    func displayRefreshInProgress()
    func hideRefreshInProgress()
    func displayNextDataRequestInProgress()
    func hideNextDataRequestInProgress()
    func display(_ error:Error)
}
