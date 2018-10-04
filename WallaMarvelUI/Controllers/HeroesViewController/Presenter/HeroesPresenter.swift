//
//  HeroesPresenter.swift
//  WallaMarvel
//
//  Created Mario Plaza on 3/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import UIKit
import WallaMarvelAPI

final class HeroesPresenter {
    weak var attachedView: HeroesViewProtocol!
}

extension HeroesPresenter: HeroesPresenterProtocol{
    func display(_ characters:[WallaMarvelAPI.Character]){
        let charactersDisplayData = characters.map{ return HeroesDisplayData.SingleHeroDisplay(imageURL: $0.thumbnail.url, title: $0.name, description: nil) }
        let toDisplayData = HeroesDisplayData(characters: charactersDisplayData)
        attachedView.displayHeroesData(toDisplayData)
    }
    
    func displayProgress(){
        attachedView.drawProgressHUD()
    }
    
    func hideProgress(){
        attachedView.hideProgressHUD()
    }
    
    func display(_ error:Error){
        attachedView.drawErrorHUD(error, dismissAfter: 2.5)
    }
}
