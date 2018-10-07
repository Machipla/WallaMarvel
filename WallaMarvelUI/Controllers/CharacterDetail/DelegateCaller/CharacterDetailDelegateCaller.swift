//
//  CharacterDetailDelegateCaller.swift
//  WallaMarvel
//
//  Created Mario Plaza on 4/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import UIKit

final class CharacterDetailDelegateCaller{
    weak var attachedView: CharacterDetailViewController!
}

extension CharacterDetailDelegateCaller: CharacterDetailDelegateCallerProtocol {
    func callDelegateForDismissDone(){
        attachedView.delegate?.characterDetailViewControllerHasBeenDismised(attachedView)
    }
}
