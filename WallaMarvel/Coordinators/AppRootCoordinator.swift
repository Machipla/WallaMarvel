//
//  AppRootCoordinator.swift
//  WallaMarvel
//
//  Created by Mario Plaza on 3/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import Foundation
import UIKit
import WallaMarvelUI

final class AppRootCoordinator: Coordinator, Startable{
    var childs = [Coordinator]()

    private(set) weak var rootNavigationController:UINavigationController?
    private(set) weak var heroesListController:HeroesViewController?
    
    let launchOptions:[UIApplication.LaunchOptionsKey:Any]?
    let mainWindow:UIWindow
    
    init(launchOptions:[UIApplication.LaunchOptionsKey:Any]?, window:UIWindow){
        self.launchOptions = launchOptions
        self.mainWindow = window
    }
    
    func start(){
        let heroesListController = HeroesViewController()
        
        let rootNavigationController = UINavigationController(rootViewController: heroesListController)
        
        mainWindow.rootViewController = rootNavigationController
        mainWindow.makeKeyAndVisible()
        
        self.heroesListController = heroesListController
        self.rootNavigationController = rootNavigationController
    }
}
