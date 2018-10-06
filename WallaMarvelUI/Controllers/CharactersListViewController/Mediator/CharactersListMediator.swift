//
//  CharactersListMediator.swift
//  WallaMarvel
//
//  Created Mario Plaza on 3/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import UIKit
import ErrorHandler
import Promises
import WallaMarvelKit
import WallaMarvelAPI

final class CharactersListMediator {
    var presenter: CharactersListPresenterProtocol!
    var delegateCaller: CharactersListDelegateCallerProtocol!
    
    private var currentCursor = Cursor()
    private var currentCharacters = [WallaMarvelAPI.Character]()
    private var currentFilter = CharactersFilter()
}

private extension CharactersListMediator{
    func loadDataAndHandleErrorIfAny() -> Promise<API.Characters.Get.CharactersResult>{
        return API.Characters.Get.all(filteringBy: currentFilter, cursor: currentCursor).catch { error in
            ErrorHandler.default.handle(error)
            self.presenter.display(error)
        }
    }
}

extension CharactersListMediator: CharactersListMediatorProtocol{
    func reloadData(){
        currentCursor.resetToFirstResults()
        
        presenter.displayProgress()
        loadDataAndHandleErrorIfAny().then{ result in
            self.currentCursor = result.nextCursor
            self.currentCharacters = result.characters
            
            self.presenter.displayReloadCharacters(result.characters)
        }.always {
            self.presenter.hideProgress()
        }
    }
    
    func refreshTriggered(){
        currentCursor.resetToFirstResults()
        
        presenter.displayRefreshInProgress()
        loadDataAndHandleErrorIfAny().then{ result in
            self.currentCursor = result.nextCursor
            self.currentCharacters = result.characters
            
            self.presenter.displayRefreshCharacters(result.characters)
        }.always {
            self.presenter.hideRefreshInProgress()
        }
    }
    
    func nextDataRequestTriggered(){
        presenter.displayNextDataRequestInProgress()
        loadDataAndHandleErrorIfAny().then{ result in
            self.currentCursor = result.nextCursor
            self.currentCharacters.append(contentsOf: result.characters)
            
            self.presenter.displayNextDataCharacters(result.characters)
        }.always {
            self.presenter.hideNextDataRequestInProgress()
        }
    }
    
    func searchHasChanged(to text:String?){
        currentFilter.name = text
        reloadData()
        
        presenter.updateSearch(to: text)
    }
    
    func filtersTapped(){
        presenter.displayFiltersView(with: currentFilter)
    }
    
    func characterTapped(at index:Int){
        guard let selectedCharacter = currentCharacters[safe: index] else { return }
        delegateCaller.callDelegateForCharacterSelected(selectedCharacter)
    }
    
    func newFiltersSelected(_ filters:CharactersFilter){
        currentFilter = filters
        reloadData()
        
        presenter.updateSearch(to: currentFilter.name)
    }
}

