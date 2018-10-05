//
//  CharacterDetailPresenter.swift
//  WallaMarvel
//
//  Created Mario Plaza on 4/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import UIKit
import WallaMarvelAPI

final class CharacterDetailPresenter {
    weak var attachedView: CharacterDetailViewProtocol!
}

extension CharacterDetailPresenter: CharacterDetailPresenterProtocol{
    func display(_ character:WallaMarvelAPI.Character){
        let displayData = CharacterDetailDisplayData(name: character.name, description: character.description, imageURL: character.thumbnail.url)
        attachedView.display(displayData)
    }
    
    func displayImageDetail(for character:WallaMarvelAPI.Character){
        let imageDisplayData = CharacterImageDetailDisplayData(imageURL: character.thumbnail.url, title: character.name)
        attachedView.displayImage(with: imageDisplayData)
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
    
    func display(_ error:Error){
        attachedView.drawErrorHUD(error, dismissAfter: 2.5)
    }
}
