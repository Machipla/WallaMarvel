//
//  CharactersFilterPresenter.swift
//  WallaMarvel
//
//  Created Mario Plaza on 6/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import UIKit
import WallaMarvelAPI

final class CharactersFilterPresenter {
    weak var attachedView: CharactersFilterViewProtocol!
}

extension CharactersFilterPresenter: CharactersFilterPresenterProtocol{
    func display(_ filters:CharactersFilter?){
        let displayData = CharactersFilterDisplayData(name: filters?.name,
                                                      nameStartsWith: filters?.nameStartsWith,
                                                      modifiedSince: filters?.modifiedSince,
                                                      orderBy: CharactersOrderByDisplayData(orderBy: filters?.orderBy ?? .ascendingByName),
                                                      selectedComicsCount: filters?.comicIDs.count ?? 0)
        attachedView.display(displayData)
    }
    
    func displayComicsSelectorPreselectingComicsWithIDs(_ comicsIDs:[String]){
        attachedView.displayComicsSelectorPreselectingComicsWithIDs(comicsIDs)
    }
}
