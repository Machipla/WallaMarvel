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
    
    fileprivate let config:ComicsListControllerConfig
    
    private var currentFilter = ComicsFilter()
    private var currentCursor = Cursor()
    private var comics = [Comic]()
    
    init(config:ComicsListControllerConfig){
        self.config = config
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
            
            self.presenter.displayReloadComics(result.comics)
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
            
            self.presenter.displayRefreshComics(result.comics)
        }.always {
            self.presenter.hideRefreshInProgress()
        }
    }
    
    func nextDataRequestTriggered(){
        presenter.displayNextDataRequestInProgress()
        loadDataAndHandleErrorIfAny().then{ result in
            self.currentCursor = result.nextCursor
            self.comics.append(contentsOf: result.comics)
            
            self.presenter.displayNextDataComics(result.comics)
        }.always {
            self.presenter.hideNextDataRequestInProgress()
        }
    }
    
    func searchHasChanged(to text:String?){
        currentFilter.title = text
        reloadData()
        
        presenter.updateSearch(to: text)
    }

    func comicSelected(at index:Int){
        
    }
}
