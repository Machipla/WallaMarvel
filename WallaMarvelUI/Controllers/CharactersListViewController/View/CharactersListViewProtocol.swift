//
//  CharactersListViewProtocol.swift
//  WallaMarvel
//
//  Created Mario Plaza on 3/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import UIKit
import WallaMarvelAPI

protocol CharactersListViewProtocol: class, HUDDrawer {
    func displayCharactersData(_ displayData:CharactersDisplayData, behavior:CharactersDisplayBehavior)
    func displayFiltersView(with preSelectedFilter:CharactersFilter)
    
    func drawRefreshProgressView()
    func hideRefreshProgressView()
    func drawNextDataRequestProgressView()
    func hideNextDataRequestProgressView()
}
