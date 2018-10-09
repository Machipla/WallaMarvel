//
//  Notifications.swift
//  WallaMarvel
//
//  Created by Mario Plaza on 8/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import Foundation
import UserNotifications
import Promises
import SwiftDate

struct Notifications{
    private init(){}
}

extension Notifications{
    static func requestAuthorizationIfNecessary(){
        if #available(iOS 10.0, *){
            UNUserNotificationCenter.current().requestAuthorization(options: [.badge,.sound,.alert]) { _, _ in }
        }else{
            let settings = UIUserNotificationSettings(types: [.badge,.sound,.alert], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(settings)
        }
    }
    
    static func scheduleLocalNotificationForUserEngageIfNecessary(){
        var notification = LocalNotification(ID: Notifications.Kind.userEngage.notificationID)
        notification.title = .localizedStringKey("LOCAL_NOTIFICATION_USER_ENGAGE_TITLE")
        notification.body = .localizedStringKeyHandler({
            return ["LOCAL_NOTIFICATION_USER_ENGAGE_MESSAGE_TITLE_1",
                    "LOCAL_NOTIFICATION_USER_ENGAGE_MESSAGE_TITLE_2",
                    "LOCAL_NOTIFICATION_USER_ENGAGE_MESSAGE_TITLE_3"].randomElement()!
        })
        notification.triggerAt = 2.days
        notification.repeats = true
        notification.sound = .default

        removePreviouslyEnqueuedNotifications(for: .userEngage)
        fire(notification)
    }
    
    static func removeAllPreviouslyEnqueuedNotifications(){
        if #available(iOS 10.0, *){
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        }else{
            
            UIApplication.shared.cancelAllLocalNotifications()
        }
    }
    
    static func removePreviouslyEnqueuedNotifications(for kind:Notifications.Kind){
        if #available(iOS 10.0, *){
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [kind.notificationID])
        }else{
            guard let scheduledLocalNotifications = UIApplication.shared.scheduledLocalNotifications else { return }
            
            let toRemoveNotifications = scheduledLocalNotifications.filter{ ($0.userInfo?["ID"] as? String) == kind.notificationID }
            toRemoveNotifications.forEach{ UIApplication.shared.cancelLocalNotification($0) }
        }
    }
    
    static func fire(_ notification:LocalNotification){
        if #available(iOS 10.0, *){
            UNUserNotificationCenter.current().add(notification.asNotificationRequest, withCompletionHandler: nil)
        }else{
            UIApplication.shared.scheduleLocalNotification(notification.asLocalNotification)
        }
    }
    
}
