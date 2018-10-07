//
//  ComicsListViewProtocol.swift
//  WallaMarvel
//
//  Created Mario Plaza on 6/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import UIKit

protocol ComicsListViewProtocol: class, HUDDrawer {
    func displayComicsData(_ displayData:ComicsListDisplayData, behavior:ComicsDisplayBehavior)
    func displaySearch(_ search:String?)
    func deselectAll()
    
    func drawRefreshProgressView()
    func hideRefreshProgressView()
    func drawNextDataRequestProgressView()
    func hideNextDataRequestProgressView()
}
