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
        return API.Comics.Get.all(filteringBy: currentFilter, cursor: currentCursor).catch { [weak self] error in
            ErrorHandler.default.handle(error)
            self?.presenter.display(error)
        }
    }
}

extension ComicsListMediator: ComicsListMediatorProtocol{
    func reloadData(){
        currentCursor.resetToFirstResults()
        
        presenter.displayProgress()
        loadDataAndHandleErrorIfAny().then{ [weak self] result in
            guard let strongSelf = self else { return }
            
            strongSelf.currentCursor = result.nextCursor
            strongSelf.comics = result.comics
            
            strongSelf.presenter.displayReloadComics(result.comics, withSelectedOnesIDs: strongSelf.selectedComicsIDs)
        }.always { [weak self] in
            self?.presenter.hideProgress()
        }
    }
    
    func refreshTriggered(){
        currentCursor.resetToFirstResults()
        
        presenter.displayRefreshInProgress()
        loadDataAndHandleErrorIfAny().then{ [weak self] result in
            guard let strongSelf = self else { return }
            strongSelf.currentCursor = result.nextCursor
            strongSelf.comics = result.comics
            
            strongSelf.presenter.displayRefreshComics(result.comics, withSelectedOnesIDs: strongSelf.selectedComicsIDs)
        }.always { [weak self] in
            self?.presenter.hideRefreshInProgress()
        }
    }
    
    func nextDataRequestTriggered(){
        presenter.displayNextDataRequestInProgress()
        loadDataAndHandleErrorIfAny().then{ [weak self] result in
            guard let strongSelf = self else { return }
            
            strongSelf.currentCursor = result.nextCursor
            strongSelf.comics.append(contentsOf: result.comics)
            
            strongSelf.presenter.displayNextDataComics(result.comics, withSelectedOnesIDs: strongSelf.selectedComicsIDs)
        }.always { [weak self] in
            self?.presenter.hideNextDataRequestInProgress()
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
