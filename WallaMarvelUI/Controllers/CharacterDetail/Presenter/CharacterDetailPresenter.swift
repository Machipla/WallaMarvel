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
        let displayData = CharacterDetailDisplayData(name: character.name,
                                                     description: character.description,
                                                     imageURL: character.thumbnail?.url,
                                                     mustShowComicsField: !(character.comicsData?.comics.isEmpty ?? true),
                                                     comicsCount: character.comicsData?.comics.count ?? 0)
        attachedView.display(displayData)
    }
    
    func displayImageDetail(for character:WallaMarvelAPI.Character){
        guard let thumbnailURL = character.thumbnail?.url else { return } // If no image is present, it makes no sense to show the image
        
        let imageDisplayData = CharacterImageDetailDisplayData(imageURL: thumbnailURL, title: character.name)
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
