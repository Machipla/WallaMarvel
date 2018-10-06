//
//  String+ISO8601.swift
//  WallaMarvelAPI
//
//  Created by Mario Plaza on 6/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import Foundation

public extension String{
    var isISO8601Date:Bool{
        if #available(iOS 11.0, *){
            return ISO8601DateFormatter().date(from: self) != nil
        }else{
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale.current
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
            dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)

            return dateFormatter.date(from: self) != nil
        }
    }
}
