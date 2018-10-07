//
//  CharacterDetailMediatorProtocol.swift
//  WallaMarvel
//
//  Created Mario Plaza on 4/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import UIKit

protocol CharacterDetailMediatorProtocol: class{
    func reloadData()
    
    func refreshTriggered()
    func imageTapped()
    func dismissDone()
}
