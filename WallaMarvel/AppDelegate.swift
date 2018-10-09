//
//  AppDelegate.swift
//  WallaMarvel
//
//  Created by Mario Plaza on 2/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import UIKit
import WallaMarvelAPI

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var startCoordinator:AppStartCoordinator!
    var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        startCoordinator = AppStartCoordinator(launchOptions: launchOptions, window: window!)
        startCoordinator.start()
        
        return true
    }
    
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        let result = startCoordinator.performShortcutItemAction(shortcutItem)
        completionHandler(result)
    }
}

