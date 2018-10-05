//
//  CharacterDetailViewProtocol.swift
//  WallaMarvel
//
//  Created Mario Plaza on 4/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import UIKit

protocol CharacterDetailViewProtocol: class, HUDDrawer {
    func display(_ data:CharacterDetailDisplayData)
    func displayImage(with data:CharacterImageDetailDisplayData)
    
    func drawRefreshProgressView()
    func hideRefreshProgressView()
}
