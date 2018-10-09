//
//  CharacterDetailMediator.swift
//  WallaMarvel
//
//  Created Mario Plaza on 4/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import UIKit
import Promises
import ErrorHandler
import WatchKit
import WallaMarvelAPI

final class CharacterDetailMediator {

    var presenter: CharacterDetailPresenterProtocol!
    var delegateCaller: CharacterDetailDelegateCallerProtocol!
    
    private var currentCharacter:WallaMarvelAPI.Character?
    fileprivate let config:CharacterDetailControllerConfig
    
    init(config:CharacterDetailControllerConfig){
        self.config = config
    }
    
}

private extension CharacterDetailMediator{
    func loadDataAndHandleErrorIfNecessary() -> Promise<WallaMarvelAPI.Character>{
        switch config {
        case .character(let character):
            return Promise(character)
        case .characterID(let characterID):
            return API.Characters.Get.byID(characterID).catch{ error in
                ErrorHandler.default.handle(error)
            }
        }
    }
}

extension CharacterDetailMediator: CharacterDetailMediatorProtocol{
    func reloadData(){
        presenter.displayProgress()
        loadDataAndHandleErrorIfNecessary().then{ [weak self] character in
            self?.currentCharacter = character
            self?.presenter.display(character)
        }.always{ [weak self] in
            self?.presenter.hideProgress()
        }
    }
    
    func refreshTriggered(){
        presenter.displayRefreshInProgress()
        loadDataAndHandleErrorIfNecessary().then{ [weak self] character in
            self?.currentCharacter = character
            self?.presenter.display(character)
        }.always{ [weak self] in
            self?.presenter.hideRefreshInProgress()
        }
    }
    
    func imageTapped(){
        guard let character = currentCharacter else { return }
        presenter.displayImageDetail(for: character)
    }
    
    func dismissDone(){
        delegateCaller.callDelegateForDismissDone()
    }
}
