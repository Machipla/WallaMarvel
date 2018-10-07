//
//  ComicsListMediator.swift
//  WallaMarvel
//
//  Created Mario Plaza on 6/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import UIKit
import Promises
import ErrorHandler
import WallaMarvelKit
import WallaMarvelAPI

final class ComicsListMediator {
    var presenter: ComicsListPresenterProtocol!
    var delegateCaller: ComicsListDelegateCallerProtocol!

    /// Current filter
    private var currentFilter = ComicsFilter()
    /// Current cursor
    private var currentCursor = Cursor()
    /// The comics currently loaded
    private var comics = [Comic]()
    /// The selected comic ID's
    private var selectedComicsIDs = [String]()
    
    init(config:ComicsListControllerConfig){
        self.selectedComicsIDs = config.preSelectedComicsIDs
    }
}

private extension ComicsListMediator{
    func loadDataAndHandleErrorIfAny() -> Promise<API.Comics.Get.ComicsResult>{
        return API.Comics.Get.all(filteringBy: currentFilter, cursor: currentCursor).catch { error in
            ErrorHandler.default.handle(error)
            self.presenter.display(error)
        }
    }
}

extension ComicsListMediator: ComicsListMediatorProtocol{
    func reloadData(){
        currentCursor.resetToFirstResults()
        
        presenter.displayProgress()
        loadDataAndHandleErrorIfAny().then{ result in
            self.currentCursor = result.nextCursor
            self.comics = result.comics
            
            self.presenter.displayReloadComics(result.comics, withSelectedOnesIDs: self.selectedComicsIDs)
        }.always {
            self.presenter.hideProgress()
        }
    }
    
    func refreshTriggered(){
        currentCursor.resetToFirstResults()
        
        presenter.displayRefreshInProgress()
        loadDataAndHandleErrorIfAny().then{ result in
            self.currentCursor = result.nextCursor
            self.comics = result.comics
            
            self.presenter.displayRefreshComics(result.comics, withSelectedOnesIDs: self.selectedComicsIDs)
        }.always {
            self.presenter.hideRefreshInProgress()
        }
    }
    
    func nextDataRequestTriggered(){
        presenter.displayNextDataRequestInProgress()
        loadDataAndHandleErrorIfAny().then{ result in
            self.currentCursor = result.nextCursor
            self.comics.append(contentsOf: result.comics)
            
            self.presenter.displayNextDataComics(result.comics, withSelectedOnesIDs: self.selectedComicsIDs)
        }.always {
            self.presenter.hideNextDataRequestInProgress()
        }
    }
    
    func searchHasChanged(to text:String?){
        let searchIsStillEmpty = (text?.isEmpty ?? true) && (currentFilter.title?.isEmpty ?? true)
        let searchHasChanged = currentFilter.title != text && !searchIsStillEmpty
        guard searchHasChanged else { return }
        
        currentFilter.title = text
        reloadData()
        
        presenter.updateSearch(to: text)
    }

    func comicSelected(at index:Int){
        guard let comic = comics[safe: index], let comicID = comic.ID else { return }
        
        if selectedComicsIDs.contains(comicID){
            selectedComicsIDs.remove(comicID)
        }else{
            selectedComicsIDs.append(comicID)
        }
    }
    
    func dismissTapped(){
        delegateCaller.callDelegateForComicsSelected(withIDs: selectedComicsIDs)
    }
    
    func clearSelectionTapped(){
        selectedComicsIDs.removeAll()
        presenter.deselectAll()
    }
}
