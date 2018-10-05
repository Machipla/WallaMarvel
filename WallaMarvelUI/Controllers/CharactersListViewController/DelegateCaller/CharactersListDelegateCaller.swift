//
//  CharactersListDelegateCaller.swift
//  WallaMarvel
//
//  Created Mario Plaza on 3/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import UIKit
import WallaMarvelAPI

final class CharactersListDelegateCaller{
    weak var attachedView: CharactersListViewController!
}

extension CharactersListDelegateCaller: CharactersListDelegateCallerProtocol {
    func callDelegateForCharacterSelected(_ selectedCharacter:WallaMarvelAPI.Character){
        attachedView.delegate?.charactersListViewController(attachedView, hasSelected: selectedCharacter)
    }
}
