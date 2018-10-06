//
//  CharacterFiltersMediator.swift
//  WallaMarvel
//
//  Created Mario Plaza on 6/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import UIKit

final class CharacterFiltersMediator {

    var presenter: CharacterFiltersPresenterProtocol!
    var delegateCaller: CharacterFiltersDelegateCallerProtocol!
    var dataProvider: CharacterFiltersDataProviderProtocol!
    
    fileprivate let config:CharacterFiltersControllerConfig
    
    init(config:CharacterFiltersControllerConfig){
        self.config = config
    }
}

extension CharacterFiltersMediator: CharacterFiltersMediatorProtocol{
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
}
