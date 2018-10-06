//
//  CharacterFiltersDisplayData.swift
//  WallaMarvel
//
//  Created Mario Plaza on 6/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import UIKit
import Eureka
import WallaMarvelAPI

// MARK: - Display data
struct CharacterFiltersDisplayData {
    public var name:String?
    public var nameStartsWith:String?
    public var modifiedSince:Date?
    public var orderBy:CharacterOrderByDisplayData?
}

// MARK: - OrderBy display data
enum CharacterOrderByDisplayData: Int, InputTypeInitiable{
    case ascendingByName
    case ascendingByModified
    case descendingByName
    case descendingByModified
    
    init?(string stringValue: String) {
        guard let rawValue = Int(stringValue) else { return nil }
        self.init(rawValue: rawValue)
    }
    
    init(orderBy:CharacterOrderBy){
        switch orderBy {
        case .ascendingByName:      self = .ascendingByName
        case .ascendingByModified:  self = .ascendingByModified
        case .descendingByName:     self = .descendingByName
        case .descendingByModified: self = .descendingByModified
        }
    }
    
    var orderByValue:CharacterOrderBy{
        switch self {
        case .ascendingByName:      return .ascendingByName
        case .ascendingByModified:  return .ascendingByModified
        case .descendingByName:     return .descendingByName
        case .descendingByModified: return .descendingByModified
        }
    }
    
    var localizedString:String{
        switch self {
        case .ascendingByName:      return "CHARACTER_FILTERS_ORDER_BY_NAME_ASC".localized(on: WallaMarvelUI.bundle)
        case .ascendingByModified:  return "CHARACTER_FILTERS_ORDER_BY_MODIFIED_DATE_ASC".localized(on: WallaMarvelUI.bundle)
        case .descendingByName:     return "CHARACTER_FILTERS_ORDER_BY_NAME_DESC".localized(on: WallaMarvelUI.bundle)
        case .descendingByModified: return "CHARACTER_FILTERS_ORDER_BY_MODIFIED_DATE_DESC".localized(on: WallaMarvelUI.bundle)
        }
    }
}
