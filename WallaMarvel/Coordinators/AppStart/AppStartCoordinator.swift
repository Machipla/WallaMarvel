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

final class AppStartCoordinator: Coordinator, Startable{
    var childs = [Coordinator]()
    
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
        
        DefaultStyleSheet.apply()
    }
}
