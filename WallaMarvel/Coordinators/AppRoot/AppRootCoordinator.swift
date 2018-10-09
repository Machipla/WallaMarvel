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
    
    let mainWindow:UIWindow
    
    init(window:UIWindow){
        self.mainWindow = window
    }
    
    func start(){
        let charactersListController = CharactersListViewController()
        charactersListController.delegate = self
        
        let rootNavigationController = UINavigationController(rootViewController: charactersListController)
        
        mainWindow.rootViewController = rootNavigationController
        mainWindow.makeKeyAndVisible()
        
        charactersListController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_menu")!, style: .plain, target: self, action: #selector(menuTapped))
        
        self.charactersListController = charactersListController
        self.rootNavigationController = rootNavigationController
    }
}

private extension AppRootCoordinator{
    func startCharacterDetailCoordinator(for character:WallaMarvelAPI.Character){
        let detailCoordinator = CharacterDetailCoordinator(fromNavigationController: rootNavigationController, character: character)
        detailCoordinator.delegate = self
        startChild(detailCoordinator)
    }
}

private extension AppRootCoordinator{
    @objc func menuTapped(){
        let aboutCoordinator = AboutCoordinator(fromController: rootNavigationController)
        aboutCoordinator.delegate = self
        startChild(aboutCoordinator)
    }
}

extension AppRootCoordinator: CharactersListViewControllerDelegate{
    func charactersListViewController(_ controller: CharactersListViewController, hasSelected character: WallaMarvelAPI.Character) {
        startCharacterDetailCoordinator(for: character)
    }
    
    func charactersListViewController(_ controller: CharactersListViewController, hasSelectedPreviewFor character: WallaMarvelAPI.Character) -> UIViewController? {
        let detailCoordinator = CharacterDetailCoordinator(fromNavigationController: rootNavigationController, character: character)
        detailCoordinator.delegate = self
        addChild(detailCoordinator)
        return detailCoordinator.startForViewControllerPreviewPeek()
    }
    
    func charactersListViewController(_ controller: CharactersListViewController, hasAcceptedPreviewFor character: WallaMarvelAPI.Character) {
        startCharacterDetailCoordinator(for: character)
    }
}

extension AppRootCoordinator: CharacterDetailCoordinatorDelegate{
    func characterDetailCoordinatorHasFinished(_ coordinator: CharacterDetailCoordinator) {
        removeChild(coordinator)
    }
}

extension AppRootCoordinator: AboutCoordinatorDelegate{
    func aboutCoordinatorHasFinished(_ coordinator: AboutCoordinator) {
        removeChild(coordinator)
    }
}
