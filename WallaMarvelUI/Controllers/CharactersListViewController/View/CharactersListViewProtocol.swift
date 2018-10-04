//
//  CharactersListViewProtocol.swift
//  WallaMarvel
//
//  Created Mario Plaza on 3/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import UIKit

protocol CharactersListViewProtocol: class, HUDDrawer {
    func displayHeroesData(_ displayData:CharactersDisplayData)
}
