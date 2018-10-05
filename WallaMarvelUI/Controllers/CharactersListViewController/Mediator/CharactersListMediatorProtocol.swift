//
//  CharactersListMediatorProtocol.swift
//  WallaMarvel
//
//  Created Mario Plaza on 3/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import UIKit

protocol CharactersListMediatorProtocol: class{
    func reloadData()
    
    func refreshTriggered()
    func nextDataRequestTriggered()
    func searchHasChanged(to text:String?)
    func filtersTapped()
    func characterTapped(at index:Int)
}
