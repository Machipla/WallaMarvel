//
//  CharacterFiltersPresenter.swift
//  WallaMarvel
//
//  Created Mario Plaza on 6/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import UIKit
import WallaMarvelAPI

final class CharacterFiltersPresenter {
    weak var attachedView: CharacterFiltersViewProtocol!
}

extension CharacterFiltersPresenter: CharacterFiltersPresenterProtocol{
    func display(_ filters:CharactersFilter?){
        let displayData = CharacterFiltersDisplayData(name: filters?.name,
                                                      nameStartsWith: filters?.nameStartsWith,
                                                      modifiedSince: filters?.modifiedSince,
                                                      orderBy: CharacterOrderByDisplayData(orderBy: filters?.orderBy ?? .ascendingByName))
        attachedView.display(displayData)
    }
}
