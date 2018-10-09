//
//  DeepLinksCoordinator.swift
//  WallaMarvel
//
//  Created by Mario Plaza on 9/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import Foundation
import UIKit
import DeepLinkKit
import WallaMarvelUI

final class DeepLinksCoordinator: Coordinator, Startable{
    var childs = [Coordinator]()
    
    private let router = DPLDeepLinkRouter()
    
    func start(){
        registerAllDeepLinks()
    }
    
    @discardableResult
    func performShortcutItemAction(_ shortcutItem:UIApplicationShortcutItem) -> Bool{
        guard let linkURL = URL(string: shortcutItem.type) else { return false }
        return router.handle(linkURL, withCompletion: nil)
    }
}

private extension DeepLinksCoordinator{
    func registerAllDeepLinks(){
        router.register(DeepLinkPaths.charactersSearch, routeHandlerBlock: redirectToCharactersSearch(_:))
    }
    
    private func redirectToCharactersSearch(_ deepLink:DPLDeepLink?){
        guard let rootController = UIApplication.shared.keyWindow?.rootViewController,
            let rootNavigationController = rootController as? UINavigationController,
            let charactersController = rootNavigationController.rootViewController as? CharactersListViewController  else { return }
        
        rootNavigationController.popToRootViewController(animated: true) {
            if charactersController.viewIfLoaded == nil{
                // We wait for the current view to load if not loaded yet
                CATransaction.begin()
                CATransaction.setCompletionBlock { charactersController.searchController?.searchBar.becomeFirstResponder() }
                CATransaction.commit()
            }else{
                charactersController.searchController?.searchBar.becomeFirstResponder()
            }
        }
    }
}
