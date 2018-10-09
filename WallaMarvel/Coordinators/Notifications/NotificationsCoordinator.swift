//
//  NotificationsCoordinator.swift
//  WallaMarvel
//
//  Created by Mario Plaza on 9/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import Foundation
import UIKit

final class NotificationsCoordinator: Coordinator, Startable{
    var childs = [Coordinator]()
    
    deinit{
        NotificationCenter.default.removeObserver(self)
    }
    
    init(){
        NotificationCenter.default.addObserver(self, selector: #selector(updateScheduledNotifications), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    func start(){
        Notifications.requestAuthorizationIfNecessary()
        updateScheduledNotifications()
    }
    
    @objc private func updateScheduledNotifications(){
        Notifications.scheduleLocalNotificationForUserEngageIfNecessary()
    }
}
