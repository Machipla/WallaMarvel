//
//  CharactersListPresenter.swift
//  WallaMarvel
//
//  Created Mario Plaza on 3/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import UIKit
import WallaMarvelAPI

final class CharactersListPresenter {
    weak var attachedView: CharactersListViewProtocol!
}

extension CharactersListPresenter: CharactersListPresenterProtocol{
    func displayReloadCharacters(_ characters:[WallaMarvelAPI.Character]){
        let charactersDisplayData = characters.map{ return CharactersDisplayData.SingleCharacterDisplay(imageURL: $0.thumbnail.url, title: $0.name, description: nil) }
        let toDisplayData = CharactersDisplayData(characters: charactersDisplayData)
        attachedView.displayHeroesData(toDisplayData, behavior: .removingOldOnes)
    }
    
    func displayRefreshCharacters(_ characters:[WallaMarvelAPI.Character]){
        displayReloadCharacters(characters) // Refreshing and reloading represents the same behavior.
    }
    
    func displayNextDataCharacters(_ characters:[WallaMarvelAPI.Character]){
        let charactersDisplayData = characters.map{ return CharactersDisplayData.SingleCharacterDisplay(imageURL: $0.thumbnail.url, title: $0.name, description: nil) }
        let toDisplayData = CharactersDisplayData(characters: charactersDisplayData)
        attachedView.displayHeroesData(toDisplayData, behavior: .appendingToOldOnes)
    }
    
    func displayProgress(){
        attachedView.drawProgressHUD()
    }
    
    func hideProgress(){
        attachedView.hideProgressHUD()
    }
    
    func displayRefreshInProgress(){
        attachedView.drawRefreshProgressView()
    }
    
    func hideRefreshInProgress(){
        attachedView.hideRefreshProgressView()
    }
    
    func displayNextDataRequestInProgress(){
        attachedView.drawNextDataRequestProgressView()
    }
    
    func hideNextDataRequestInProgress(){
        attachedView.hideNextDataRequestProgressView()
    }
    
    func display(_ error:Error){
        attachedView.drawErrorHUD(error, dismissAfter: 2.5)
    }
}
