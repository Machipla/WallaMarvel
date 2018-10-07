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
    
    fileprivate let config:CharactersFilterControllerConfig
    private var filterByComics = [Comic]()
    
    init(config:CharactersFilterControllerConfig){
        self.config = config
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
        let generatedFilter = dataProvider.provideData()

        delegateCaller.callDelegateForNewFiltersSelected(generatedFilter)
    }
    
    func comicsFilterTapped(){
        presenter.displayComicsSelector()
    }
    
    func comicsSelected(_ comics:[Comic]){
        filterByComics = comics
    }
}
