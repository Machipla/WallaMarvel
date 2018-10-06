//
//  ComicsListPresenterProtocol.swift
//  WallaMarvel
//
//  Created Mario Plaza on 6/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import UIKit
import WallaMarvelAPI

protocol ComicsListPresenterProtocol: class{
    func displayReloadComics(_ comics:[Comic])
    func displayRefreshComics(_ comics:[Comic])
    func displayNextDataComics(_ comics:[Comic])
    func updateSearch(to newSearch:String?)
    
    func displayProgress()
    func hideProgress()
    func displayRefreshInProgress()
    func hideRefreshInProgress()
    func displayNextDataRequestInProgress()
    func hideNextDataRequestInProgress()
    func display(_ error:Error)
}
