//
//  LocalNotification.swift
//  WallaMarvel
//
//  Created by Mario Plaza on 9/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications
import SwiftDate

/// LocalNotification represent a local notification object and is a mapping struct between different API's for iOS >= 10 and iOS <= 9
struct LocalNotification{
    /// The ID of the notification. It will be added to the mapped notification object if possible.
    var ID:String
    /// Title for the notification if any
    var title:LocalNotification.StringProvider?
    /// Body for the notification if any
    var body:LocalNotification.StringProvider?
    /// Sound for the notification
    var sound:LocalNotification.Sound
    /// The trigger date as a date component. For example if 2 days are specified, the notification will trigger 2 days after the notification is created (Not scheduled).
    /// If nil, the notification will be fired inmediately.
    var triggerAt:DateComponents?
    /// If true the notification will fire every time as defined in 'triggerAt' variable, otherwise the notification will just be fired a single time.
    var repeats:Bool
    
    init(ID:String,
         title:LocalNotification.StringProvider? = nil,
         body:LocalNotification.StringProvider? = nil,
         sound:LocalNotification.Sound = .default,
         triggerAt:DateComponents? = nil,
         repeats:Bool = false){
        self.ID = ID
        self.title = title
        self.body = body
        self.sound = sound
        self.triggerAt = triggerAt
        self.repeats = repeats
    }
    
    @available(iOS 10.0, *)
    var asNotificationRequest:UNNotificationRequest{
        let content = UNMutableNotificationContent()
        content.title = title?.rawValue ?? ""
        content.body  = body?.rawValue ?? ""
        content.sound = sound.asNotificationSound
        
        let triggerAtComponents = triggerAt == nil ? 0.seconds : triggerAt!
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: (Date() + triggerAtComponents).timeIntervalSinceNow, repeats: repeats)
        let notificationRequest = UNNotificationRequest(identifier: ID, content: content, trigger: trigger)
        return notificationRequest
    }
    
    var asLocalNotification:UILocalNotification{
        let notification = UILocalNotification()
        notification.alertTitle = title?.rawValue
        notification.alertBody = body?.rawValue
        notification.soundName = sound.asNotificationSoundName
        notification.userInfo = ["ID":ID]
        
        if let triggerAt = triggerAt{
            notification.fireDate = Date() + triggerAt
        }
        
        if repeats{
            notification.repeatCalendar = triggerAt?.calendar
        }
        
        return notification
    }
}

extension LocalNotification{
    enum Sound{
        case `default`
        case file(name:String?)
        @available(iOS 10.0, *)
        case other(UNNotificationSound)
        
        @available(iOS 10.0, *)
        var asNotificationSound:UNNotificationSound?{
            switch self {
            case .default:          return .default
            case .other(let sound): return sound
            case .file(let name):
                if let name = name{
                    return UNNotificationSound(named: UNNotificationSoundName(rawValue: name))
                }else{
                    return nil
                }
            }
        }
        
        var asNotificationSoundName:String?{
            switch self {
            case .default:          return UILocalNotificationDefaultSoundName
            case .file(let name):   return name
            default:                return nil
            }
        }
    }
}

extension LocalNotification{
    enum StringProvider: RawRepresentable{
        case string(String)
        case handler(() -> String)
        case localizedStringKey(String)
        case localizedStringKeyHandler(() -> String)
        
        init?(rawValue: String) {
            self = .string(rawValue)
        }
        
        var rawValue:String{
            switch self {
            case .string(let string):   return string
            case .handler(let handler): return handler()
            case .localizedStringKey(let stringKey):
                if #available(iOS 10.0, *){
                    return stringKey.localizedForUserNotification()
                }else{
                    return stringKey.localized()
                }
            case .localizedStringKeyHandler(let stringKeyHandler):
                if #available(iOS 10.0, *){
                    return stringKeyHandler().localizedForUserNotification()
                }else{
                    return stringKeyHandler().localized()
                }
            }
        }
    }
}
