//
//  ComicsListDisplayData.swift
//  WallaMarvel
//
//  Created Mario Plaza on 6/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import UIKit

// MARK: - Comics display data
struct ComicsListDisplayData {
    struct SingleComicDisplay{
        let title:String
    }
    
    let comics:[SingleComicDisplay]
}

// MARK: - Comic display behaviors
enum ComicsDisplayBehavior{
    case removingOldOnes
    case appendingToOldOnes
}
