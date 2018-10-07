//
//  CharactersFilterMediatorProtocol.swift
//  WallaMarvel
//
//  Created Mario Plaza on 6/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import UIKit
import WallaMarvelAPI

protocol CharactersFilterMediatorProtocol: class{
    func reloadData()
    
    func cancelTapped()
    func doneTapped()
    func comicsFilterTapped()
    func comicsSelected(_ comicIDs:[String])
}
