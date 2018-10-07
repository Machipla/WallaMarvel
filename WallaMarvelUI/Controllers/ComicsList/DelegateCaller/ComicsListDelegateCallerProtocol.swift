//
//  ComicsListDelegateCallerProtocol.swift
//  WallaMarvel
//
//  Created Mario Plaza on 6/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import UIKit

protocol ComicsListDelegateCallerProtocol: class{
    func callDelegateForComicsSelected(withIDs comicIDs:[String])
}
