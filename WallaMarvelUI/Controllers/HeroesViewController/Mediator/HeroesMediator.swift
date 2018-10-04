//
//  HeroesMediator.swift
//  WallaMarvel
//
//  Created Mario Plaza on 3/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import UIKit
import ErrorHandler
import WallaMarvelKit
import WallaMarvelAPI

final class HeroesMediator {
    var presenter: HeroesPresenterProtocol!
    var delegateCaller: HeroesDelegateCallerProtocol!
    
    private var currentCursor = Cursor()
    private var currentCharacters = [WallaMarvelAPI.Character]()
}

extension HeroesMediator: HeroesMediatorProtocol{
    func reloadData(){
        presenter.displayProgress()
        API.Characters.Get.all(cursor: currentCursor).then{ result in
            self.currentCursor = result.nextCursor
            self.currentCharacters = result.characters
            
            self.presenter.display(result.characters)
        }.catch { error in
            ErrorHandler.default.handle(error)
            self.presenter.display(error)
        }.always {
            self.presenter.hideProgress()
        }
    }
    
    func filtersTapped(){
        
    }
}
