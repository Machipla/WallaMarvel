//
//  AppRootCoordinator.swift
//  WallaMarvel
//
//  Created by Mario Plaza on 3/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import Foundation
import UIKit
import WallaMarvelAPI
import WallaMarvelUI

final class AppRootCoordinator: Coordinator, Startable{
    var childs = [Coordinator]()

    /// Root navigation controller of the app. Only accessible if root coordinator is started, otherwise it raises an exception
    private(set) weak var rootNavigationController:UINavigationController!
    /// Root controller of the app. Only accessible if root coordinator is started, otherwise it raises an exception
    private(set) weak var charactersListController:CharactersListViewController!
    
    let launchOptions:[UIApplication.LaunchOptionsKey:Any]?
    let mainWindow:UIWindow
    
    init(launchOptions:[UIApplication.LaunchOptionsKey:Any]?, window:UIWindow){
        self.launchOptions = launchOptions
        self.mainWindow = window
    }
    
    func start(){
        let charactersListController = CharactersListViewController()
        charactersListController.delegate = self
        
        let rootNavigationController = UINavigationController(rootViewController: charactersListController)
        
        mainWindow.rootViewController = rootNavigationController
        mainWindow.makeKeyAndVisible()
        
        DefaultStyleSheet.apply()
        
        self.charactersListController = charactersListController
        self.rootNavigationController = rootNavigationController
    }
}

extension AppRootCoordinator: CharactersListViewControllerDelegate{
    func charactersListViewController(_ controller: CharactersListViewController, hasSelected character: WallaMarvelAPI.Character) {
        let detailCoordinator = CharacterDetailCoordinator(fromNavigationController: rootNavigationController, character: character)
        startChild(detailCoordinator)
    }
}
