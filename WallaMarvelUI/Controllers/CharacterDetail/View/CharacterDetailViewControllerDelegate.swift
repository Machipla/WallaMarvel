//
//  CharacterDetailPresenterViewControllerDelegate.swift
//  WallaMarvel
//
//  Created Mario Plaza on 4/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import UIKit

public protocol CharacterDetailViewControllerDelegate: class {
    func characterDetailViewControllerHasBeenDismised(_ controller:CharacterDetailViewController)
}

public extension CharacterDetailViewControllerDelegate{
    func characterDetailViewControllerHasBeenDismised(_ controller:CharacterDetailViewController){}
}
