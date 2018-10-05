//
//  DefaultStyleSheet.swift
//  WallaMarvel
//
//  Created by Mario Plaza on 5/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import Foundation
import WallaMarvelUI

final class DefaultStyleSheet{
    private init(){}
    
    static func apply(){
        applyNavigationBarAppearance()
        applySearchBarAppearance()
        applyBarButtonItemAppearance()
        applyAlertControllerAppearance()
        applyCharactersListAppearance()
        applyCharacterDetailAppearance()
    }
}

private extension DefaultStyleSheet{
   
    static func applyNavigationBarAppearance(){
        let navigationBarProxy = UINavigationBar.appearance()
        
        var dictTextAttributes = [NSAttributedString.Key:Any]()
        dictTextAttributes[NSAttributedString.Key.foregroundColor] = UIColor.WallaMarvel.wallapopContrast
        //        dictTextAttributes[NSFontAttributeName] = defaultFont
        
        navigationBarProxy.titleTextAttributes = dictTextAttributes
        if #available(iOS 11.0, *){ navigationBarProxy.largeTitleTextAttributes = dictTextAttributes }
        navigationBarProxy.barTintColor = UIColor.WallaMarvel.wallapop
        navigationBarProxy.tintColor = UIColor.WallaMarvel.wallapopContrast
        
        if #available(iOS 11, *){ navigationBarProxy.prefersLargeTitles = true }
    }
    
    static func applySearchBarAppearance(){
        let searchBarProxy = UISearchBar.appearance()
        let textFieldSearchBarProxy = UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self])
        
        var dictTextAttributes = [NSAttributedString.Key:Any]()
        dictTextAttributes[NSAttributedString.Key.foregroundColor] = UIColor.WallaMarvel.darkTextColor
        
        textFieldSearchBarProxy.defaultTextAttributes = dictTextAttributes
        
        searchBarProxy.tintColor = UIColor.WallaMarvel.darkTextColor
        searchBarProxy.barTintColor = UIColor.WallaMarvel.darkTextColor
        
        
        if #available(iOS 11.0, *){
            searchBarProxy.setSearchFieldBackgroundImage(UIImage(named: "bg_search_bar")!, for: .normal)
            searchBarProxy.backgroundImage = UIImage()
            searchBarProxy.searchTextPositionAdjustment = UIOffset(horizontal: 8, vertical: 0)
        }
    }
    
    static func applyBarButtonItemAppearance(){
        let barItemProxy = UIBarButtonItem.appearance()
        
        var dictTextAttributes = [NSAttributedString.Key:Any]()
        dictTextAttributes[NSAttributedString.Key.foregroundColor] = UIColor.WallaMarvel.wallapopContrast
        
        barItemProxy.setTitleTextAttributes(dictTextAttributes, for: .normal)
        barItemProxy.setTitleTextAttributes(dictTextAttributes, for: .selected)
    }
    
    static func applyAlertControllerAppearance(){
        let viewAlertControllerProxy = UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self])
        viewAlertControllerProxy.tintColor = UIColor.WallaMarvel.wallapop
    }
    
    static func applyCharactersListAppearance(){
        CharactersListViewController.Appearance.itemsFont = UIFont(name: "Ubuntu-Medium", size: UIFont.labelFontSize)!
        CharactersListViewController.Appearance.itemsSeparatorStyle = .gradient(startColor: UIColor.WallaMarvel.wallapop, endColor: UIColor.WallaMarvel.marvel)
    }
    
    static func applyCharacterDetailAppearance(){
        CharacterDetailViewController.Appearance.titleFont = UIFont(name: "Ubuntu-Bold", size: UIFont.labelFontSize)!
    }
}
