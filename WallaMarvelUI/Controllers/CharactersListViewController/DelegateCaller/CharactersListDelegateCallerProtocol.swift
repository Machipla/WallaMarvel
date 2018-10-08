//
//  CharactersListDelegateCallerProtocol.swift
//  WallaMarvel
//
//  Created Mario Plaza on 3/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import UIKit
import WallaMarvelAPI

protocol CharactersListDelegateCallerProtocol: class{
    func callDelegateForCharacterSelected(_ selectedCharacter:WallaMarvelAPI.Character)
    func callDelegateForPreviewSelected(for selectedCharacter:WallaMarvelAPI.Character)
    func callDelegateForPreviewAccepted(for selectedCharacter:WallaMarvelAPI.Character)
}
