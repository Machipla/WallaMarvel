//
//  ComicsListMediatorProtocol.swift
//  WallaMarvel
//
//  Created Mario Plaza on 6/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import UIKit

protocol ComicsListMediatorProtocol: class{
    func reloadData()
    func refreshTriggered()
    func nextDataRequestTriggered()
    func searchHasChanged(to text:String?)
    
    func comicSelected(at index:Int)
    func dismissTapped()
}
