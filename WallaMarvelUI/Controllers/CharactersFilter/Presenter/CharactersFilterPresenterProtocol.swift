//
//  CharactersFilterPresenterProtocol.swift
//  WallaMarvel
//
//  Created Mario Plaza on 6/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import UIKit
import WallaMarvelAPI

protocol CharactersFilterPresenterProtocol: class{
    func display(_ filters:CharactersFilter?)
    func displayComicsSelectorPreselectingComicsWithIDs(_ comicsIDs:[String])
}
