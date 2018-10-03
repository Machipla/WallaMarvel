//
//  APICharacterOrderBy.swift
//  WallaMarvelAPI
//
//  Created by Mario Plaza on 2/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import Foundation

public enum CharacterOrderBy: String{
    case ascendingByName        = "name"
    case ascendingByModified    = "modified"
    case descendingByName       = "-name"
    case descendingByModified   = "-modified"
}
