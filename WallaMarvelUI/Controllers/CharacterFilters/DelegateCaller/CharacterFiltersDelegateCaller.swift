//
//  CharacterFiltersDelegateCaller.swift
//  WallaMarvel
//
//  Created Mario Plaza on 6/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import UIKit
import WallaMarvelAPI

final class CharacterFiltersDelegateCaller{
    weak var attachedView: CharacterFiltersViewController!
}

extension CharacterFiltersDelegateCaller: CharacterFiltersDelegateCallerProtocol {
    func callDelegateForCancelTapped(){
        attachedView.delegate?.characterFiltersViewControllerCancelled(attachedView)
    }
    
    func callDelegateForNewFiltersSelected(_ filters:CharactersFilter){
        attachedView.delegate?.characterFiltersViewController(attachedView, hasSelected: filters)
    }
}
