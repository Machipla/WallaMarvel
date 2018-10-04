//
//  CharactersDisplayData.swift
//  WallaMarvel
//
//  Created Mario Plaza on 3/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import UIKit

// MARK: - Heroes dispay data
struct CharactersDisplayData {
    struct SingleCharacterDisplay{
        let imageURL:URL?
        let title:String?
        let description:String?
    }
    
    let characters:[SingleCharacterDisplay]
}
