//
//  CharactersFilterMediator.swift
//  WallaMarvel
//
//  Created Mario Plaza on 6/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import UIKit
import WallaMarvelAPI

final class CharactersFilterMediator {

    var presenter: CharactersFilterPresenterProtocol!
    var delegateCaller: CharactersFilterDelegateCallerProtocol!
    var dataProvider: CharactersFilterDataProviderProtocol!
    
    private let config:CharactersFilterControllerConfig
    private var filterByComicsIDs = [String]()
    
    init(config:CharactersFilterControllerConfig){
        self.config = config
        filterByComicsIDs = config.preSelectedFilters?.comicIDs ?? []
    }
}

extension CharactersFilterMediator: CharactersFilterMediatorProtocol{
    func reloadData(){
        presenter.display(config.preSelectedFilters)
    }
    
    func cancelTapped(){
        delegateCaller.callDelegateForCancelTapped()
    }
    
    func doneTapped(){
        var generatedFilter = dataProvider.provideData()
        generatedFilter.comicIDs = filterByComicsIDs
        
        delegateCaller.callDelegateForNewFiltersSelected(generatedFilter)
    }
    
    func comicsFilterTapped(){
        presenter.displayComicsSelectorPreselectingComicsWithIDs(filterByComicsIDs)
    }
    
    func comicsSelected(_ comicIDs:[String]){
        filterByComicsIDs = comicIDs
    }
    
    func clearFiltersTapped(){
        filterByComicsIDs.removeAll()
        presenter.display(nil)
    }
}
