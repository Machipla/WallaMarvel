//
//  ComicsListPresenter.swift
//  WallaMarvel
//
//  Created Mario Plaza on 6/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import UIKit
import WallaMarvelAPI

final class ComicsListPresenter {
    weak var attachedView: ComicsListViewProtocol!
}

extension ComicsListPresenter: ComicsListPresenterProtocol{
    
    func displayReloadComics(_ comics:[Comic]){
        let comicsDisplayData = comics.map{ return ComicsListDisplayData.SingleComicDisplay(title: $0.title) }
        let toDisplayData = ComicsListDisplayData(comics: comicsDisplayData)
        attachedView.displayComicsData(toDisplayData, behavior: .removingOldOnes)
    }
    
    func displayRefreshComics(_ comics:[Comic]){
        displayReloadComics(comics) // Refreshing and reloading represents the same behavior.
    }
    
    func displayNextDataComics(_ comics:[Comic]){
        let comicsDisplayData = comics.map{ return ComicsListDisplayData.SingleComicDisplay(title: $0.title) }
        let toDisplayData = ComicsListDisplayData(comics: comicsDisplayData)
        attachedView.displayComicsData(toDisplayData, behavior: .appendingToOldOnes)
    }
    
    func updateSearch(to newSearch:String?){
        attachedView.displaySearch(newSearch)
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
