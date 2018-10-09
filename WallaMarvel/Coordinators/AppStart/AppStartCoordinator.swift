//
//  AppStartCoordinator.swift
//  WallaMarvel
//
//  Created by Mario Plaza on 8/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import Foundation
import UIKit
import WallaMarvelAPI
import WallaMarvelUI

/// Coordinator that manages all the main functionalities of the app and delivers notifications into the correspondant child coordinators.
final class AppStartCoordinator: Coordinator, Startable{
    var childs = [Coordinator]()
    private var appRootCoordinator:AppRootCoordinator!              { return childs.firstOfType() }
    private var notificationsCoordinator:NotificationsCoordinator!  { return childs.firstOfType() }
    private var deepLinksCoordinator:DeepLinksCoordinator!          { return childs.firstOfType() }
    
    let launchOptions:[UIApplication.LaunchOptionsKey:Any]?
    let mainWindow:UIWindow
    
    init(launchOptions:[UIApplication.LaunchOptionsKey:Any]?, window:UIWindow){
        self.launchOptions = launchOptions
        self.mainWindow = window
    }
    
    func start(){
        let appRootCoordinator = AppRootCoordinator(window: mainWindow)
        startChild(appRootCoordinator)
        
        let notificationsCoordinator = NotificationsCoordinator()
        startChild(notificationsCoordinator)
        
        let deepLinksCoordinator = DeepLinksCoordinator()
        startChild(deepLinksCoordinator)
        
        DefaultStyleSheet.apply()
    }
    
    @discardableResult
    func performShortcutItemAction(_ shortcutItem:UIApplicationShortcutItem) -> Bool{
        return deepLinksCoordinator.performShortcutItemAction(shortcutItem)
    }
}
