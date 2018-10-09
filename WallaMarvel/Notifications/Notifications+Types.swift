//
//  Notifications+Types.swift
//  WallaMarvel
//
//  Created by Mario Plaza on 9/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import Foundation

extension Notifications{
    enum Kind{
        case userEngage
        
        var notificationID:String{
            return String(describing: self)
        }
    }
}
