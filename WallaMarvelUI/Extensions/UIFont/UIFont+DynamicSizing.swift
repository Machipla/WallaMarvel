//
//  UIFont+DynamicSizing.swift
//  WallaMarvelUI
//
//  Created by Mario Plaza on 5/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import Foundation

public extension UIFont{
    /// Scales the font and returns a new one with the appropiate text style and responsive to dynamic text changes.
    /// Note: Tries to make simpler the UIFontMetrics 'scaledFont(for:)' as it doesnt work on XCode 10
    /// - Parameter textStyle: The desired text style for the returned font
    /// - Returns: The new font with the text style applied and responsive to dynamic font
    @available(iOS 11.0, *)
    func scaledDynamicFont(for textStyle:UIFont.TextStyle) -> UIFont{
        return UIFontMetrics(forTextStyle: textStyle).scaledFont(for: scaledFont(for: textStyle))
    }
    
    /// Scales the font and returns a new one with the appropiate text style
    /// - Parameter textStyle: The desired text style for the returned font
    /// - Returns: The new font with the text style applied
    func scaledFont(for textStyle:UIFont.TextStyle) -> UIFont{
        let size  = UIFontDescriptor.preferredFontDescriptor(withTextStyle: textStyle).pointSize
        return UIFont(name: fontName, size: size)!
    }
    
    /// Scales the font and returns a new one with the appropiate text style and responsive to dynamic text changes if API is available.
    /// Note: Tries to make simpler the UIFontMetrics 'scaledFont(for:)' as it doesnt work on XCode 10
    /// - Parameter textStyle: The desired text style for the returned font
    /// - Returns: The new font with the text style applied and responsive to dynamic font if possible
    func scaledFontDynamicallyIfPossible(for textStyle:UIFont.TextStyle) -> UIFont{
        guard #available(iOS 11.0,*) else { return scaledFont(for: textStyle) }
        return scaledDynamicFont(for: textStyle)
    }
}
