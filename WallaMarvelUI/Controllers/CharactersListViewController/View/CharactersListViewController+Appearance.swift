//
//  CharactersListViewController+Appearance.swift
//  WallaMarvelUI
//
//  Created by Mario Plaza on 5/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import Foundation

public extension CharactersListViewController{
    // Namespace enum
    enum Appearance{
        /// The font to be used by the list items. Font will be re-scaled to the appropiate text style.
        public static var itemsFont:UIFont = UIFont.systemFont(ofSize: UIFont.labelFontSize)
        /// Allows the customization of the items separator
        public static var itemsSeparatorStyle:ItemSeparatorStyle = .color(.lightGray)
        
        public enum ItemSeparatorStyle{
            case color(UIColor)
            case gradient(startColor:UIColor, endColor:UIColor)
        }
    }
}
