//
//  CharactersFilterDataProvider.swift
//  WallaMarvelUI
//
//  Created by Mario Plaza on 6/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import Foundation
import WallaMarvelAPI

/// Provider of the data generated in the view in order to be understandable for the mediator.
final class CharactersFilterDataProvider{
    weak var attachedView:CharactersFilterViewController!
}

extension CharactersFilterDataProvider: CharactersFilterDataProviderProtocol{
    func provideData() -> CharactersFilter{
        let generatedFilter = CharactersFilter(name: attachedView.nameRow.value,
                                               nameStartsWith: attachedView.nameStartsByRow.value,
                                               modifiedSince: attachedView.modifiedSinceRow.value,
                                               comicIDs: [],
                                               orderBy: attachedView.orderByRow.value?.orderByValue)
        return generatedFilter
    }
}
