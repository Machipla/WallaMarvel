//
//  AppRootCoordinator.swift
//  WallaMarvel
//
//  Created by Mario Plaza on 3/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import Foundation
import UIKit

final class AppRootCoordinator: Coordinator, Startable{
    var childs = [Coordinator]()
    
    let launchOptions:[UIApplication.LaunchOptionsKey:Any]?
    let mainWindow:UIWindow
    
    init(launchOptions:[UIApplication.LaunchOptionsKey:Any]?, window:UIWindow){
        self.launchOptions = launchOptions
        self.mainWindow = window
    }
    
    func start(){
        let controller = UIViewController()
        controller.view.backgroundColor = .red
        controller.title = "Holis"
        
        let rootNavigationController = UINavigationController(rootViewController: controller)
        
        
        mainWindow.rootViewController = rootNavigationController
        mainWindow.makeKeyAndVisible()
    }
}
