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

    var rootCoordinator:AppRootCoordinator!
    var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        rootCoordinator = AppRootCoordinator(launchOptions: launchOptions, window: window!)
        rootCoordinator.start()
        
        return true
    }
}

