//
//  CharacterDetailControllerConfig.swift
//  WallaMarvel
//
//  Created Mario Plaza on 4/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import UIKit
import WallaMarvelAPI

public enum CharacterDetailControllerConfig{
    /// Load the character via the ID of him, a request will be made though and therefore some user time may be used.
    case characterID(String)
    /// Load the character by the character passed. If not all the character data is provided, some data may not be shown.
    case character(WallaMarvelAPI.Character)
}

