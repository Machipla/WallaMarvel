//
//  CharacterDetailViewController+Appearance.swift
//  WallaMarvelUI
//
//  Created by Mario Plaza on 5/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import Foundation

public extension CharacterDetailViewController{
    // Namespace enum
    enum Appearance{
        /// The font to be used by the title label. Font will be re-scaled to the appropiate text style.
        public static var titleFont:UIFont = UIFont.systemFont(ofSize: UIFont.labelFontSize)
        /// The font to be used by the detail label. Font will be re-scaled to the appropiate text style.
        public static var detailFont:UIFont = UIFont.systemFont(ofSize: UIFont.labelFontSize)
        /// The font to be used by the field labels. Font will be re-scaled to the appropiate text style.
        public static var fieldsFont:UIFont = UIFont.systemFont(ofSize: UIFont.labelFontSize)
    }
}
