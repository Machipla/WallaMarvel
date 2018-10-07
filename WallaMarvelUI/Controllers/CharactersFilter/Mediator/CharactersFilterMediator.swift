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
    
    private var selectedFilter:CharactersFilter
    
    init(config:CharactersFilterControllerConfig){
        selectedFilter = config.preSelectedFilters ?? CharactersFilter()
    }
}

extension CharactersFilterMediator: CharactersFilterMediatorProtocol{
    func reloadData(){
        presenter.display(selectedFilter)
    }
    
    func cancelTapped(){
        delegateCaller.callDelegateForCancelTapped()
    }
    
    func doneTapped(){
        var finalFilter = dataProvider.provideData()
        finalFilter.comicIDs = selectedFilter.comicIDs
        
        delegateCaller.callDelegateForNewFiltersSelected(finalFilter)
    }
    
    func comicsFilterTapped(){
        presenter.displayComicsSelectorPreselectingComicsWithIDs(selectedFilter.comicIDs)
    }
    
    func comicsSelected(_ comicIDs:[String]){
        self.selectedFilter.comicIDs = comicIDs
        presenter.display(selectedFilter)
    }
    
    func clearFiltersTapped(){
        selectedFilter = CharactersFilter()
        presenter.display(selectedFilter)
    }
}
