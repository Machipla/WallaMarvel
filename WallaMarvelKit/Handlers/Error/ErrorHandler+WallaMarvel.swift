//
//  ErrorHandler+WallaMarvel.swift
//  WallaMarvelKit
//
//  Created by Mario Plaza on 3/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import Foundation
import ErrorHandler

public extension ErrorHandler{
    public static var `default`:ErrorHandler{
        return ErrorHandler().always(do: { error -> MatchingPolicy in
            // TODO: Here will go Crashlytics or any other track error SDK
            
            return .continueMatching
        })
    }
}
