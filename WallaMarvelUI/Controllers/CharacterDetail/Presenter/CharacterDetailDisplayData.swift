//
//  CharacterDetailDisplayData.swift
//  WallaMarvel
//
//  Created Mario Plaza on 4/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import UIKit

// MARK: - Detail display data
struct CharacterDetailDisplayData {
    let name:String
    let description:String?
    let imageURL:URL?
    
    let mustShowComicsField:Bool
    let comicsCount:Int
}

// MARK: - Image detail display data
struct CharacterImageDetailDisplayData{
    let imageURL:URL
    let title:String?
    let description:String?
    
    init(imageURL:URL, title:String? = nil, description:String? = nil){
        self.imageURL = imageURL
        self.title = title
        self.description = description
    }
}
