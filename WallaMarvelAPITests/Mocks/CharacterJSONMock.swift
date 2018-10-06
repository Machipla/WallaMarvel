//
//  CharacterMappingEntityJSONMockup.swift
//  WallaMarvelAPITests
//
//  Created by Mario Plaza on 6/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import Foundation
import WallaMarvelAPI

struct CharacterJSONMock: JSONMock{
    typealias FieldType = Field
    
    enum Field: String, JSONField{
        case ID = "id"
        case name
        case description
        case modified
        case thumbnail
        case comics
    }
    
    var JSON = [String : Any]()
    
    func creatingValid() -> CharacterJSONMock {
        return injecting(on: .ID, value: .string("123")).injecting(on: .name, value: .string("Iron man"))
    }
}
