//
//  HeroesViewProtocol.swift
//  WallaMarvel
//
//  Created Mario Plaza on 3/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import UIKit

protocol HeroesViewProtocol: class, HUDDrawer {
    func displayHeroesData(_ displayData:HeroesDisplayData)
}
