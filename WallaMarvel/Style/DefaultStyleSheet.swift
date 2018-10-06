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
        applyGlobalViewAppearance()
        applyNavigationBarAppearance()
        applySearchBarAppearance()
        applyBarButtonItemAppearance()
        applyAlertControllerAppearance()
        applyTableHeaderFooterViewAppearance()
        applyTableCellsViewAppearance()
        applyCharactersListAppearance()
        applyCharacterDetailAppearance()
        applyComicsListAppearance()
    }
}

private extension DefaultStyleSheet{
   
    static func applyGlobalViewAppearance(){
        UIApplication.shared.keyWindow?.tintColor = UIColor.WallaMarvel.wallapop
    }
    
    static func applyNavigationBarAppearance(){
        let navigationBarProxy = UINavigationBar.appearance()
        
        var dictTextAttributes = [NSAttributedString.Key:Any]()
        dictTextAttributes[NSAttributedString.Key.foregroundColor] = UIColor.WallaMarvel.wallapopContrast
        dictTextAttributes[NSAttributedString.Key.font] = Fonts.ubuntuRegular.scaledFontDynamicallyIfPossible(for: .body)
        
        navigationBarProxy.titleTextAttributes = dictTextAttributes
        navigationBarProxy.barTintColor = UIColor.WallaMarvel.wallapop
        navigationBarProxy.tintColor = UIColor.WallaMarvel.wallapopContrast
        
        if #available(iOS 11, *){
            var largeTitleTextAttributes = [NSAttributedString.Key:Any]()
            largeTitleTextAttributes[NSAttributedString.Key.foregroundColor] = UIColor.WallaMarvel.wallapopContrast
            largeTitleTextAttributes[NSAttributedString.Key.font] = Fonts.ubuntuBold.scaledFontDynamicallyIfPossible(for: .largeTitle)
            
            navigationBarProxy.largeTitleTextAttributes = largeTitleTextAttributes
            navigationBarProxy.prefersLargeTitles = true
        }
    }
    
    static func applySearchBarAppearance(){
        let searchBarProxy = UISearchBar.appearance()
        let textFieldSearchBarProxy = UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self])
        let labelSearchBarProxy = UILabel.appearance(whenContainedInInstancesOf: [UISearchBar.self])
        
        var dictTextAttributes = [NSAttributedString.Key:Any]()
        dictTextAttributes[NSAttributedString.Key.foregroundColor] = UIColor.WallaMarvel.darkTextColor
        
        textFieldSearchBarProxy.defaultTextAttributes = dictTextAttributes
        textFieldSearchBarProxy.font = Fonts.ubuntuRegular.scaledFontDynamicallyIfPossible(for: .body)
        labelSearchBarProxy.font = Fonts.ubuntuRegular.scaledFontDynamicallyIfPossible(for: .body)
        
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
        dictTextAttributes[NSAttributedString.Key.font] = Fonts.ubuntuRegular.scaledFontDynamicallyIfPossible(for: .body)
        
        barItemProxy.setTitleTextAttributes(dictTextAttributes, for: .normal)
        barItemProxy.setTitleTextAttributes(dictTextAttributes, for: .selected)
        barItemProxy.setTitleTextAttributes(dictTextAttributes, for: .highlighted)
    }
    
    static func applyAlertControllerAppearance(){
        let viewAlertControllerProxy = UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self])
        viewAlertControllerProxy.tintColor = UIColor.WallaMarvel.wallapop
    }
    
    static func applyTableHeaderFooterViewAppearance(){
        let labelTableHeaderFooterViewProxy = UILabel.appearance(whenContainedInInstancesOf: [UITableViewHeaderFooterView.self])
        labelTableHeaderFooterViewProxy.font = Fonts.ubuntuRegular.scaledFontDynamicallyIfPossible(for: .subheadline)
    }
    
    static func applyTableCellsViewAppearance(){
        let labelTableHeaderFooterViewProxy = UILabel.appearance(whenContainedInInstancesOf: [UITableViewCell.self])
        labelTableHeaderFooterViewProxy.font = Fonts.ubuntuRegular.scaledFontDynamicallyIfPossible(for: .body)
    }
    
    static func applyCharactersListAppearance(){
        CharactersListViewController.Appearance.itemsFont = Fonts.ubuntuMedium
        CharactersListViewController.Appearance.noFoundItemsTitleFont = Fonts.ubuntuMedium
        CharactersListViewController.Appearance.itemsSeparatorStyle = .gradient(startColor: UIColor.WallaMarvel.wallapop, endColor: UIColor.WallaMarvel.marvel)
    }
    
    static func applyCharacterDetailAppearance(){
        CharacterDetailViewController.Appearance.titleFont = Fonts.ubuntuBold
        CharacterDetailViewController.Appearance.detailFont = Fonts.ubuntuRegular
        CharacterDetailViewController.Appearance.detailFont = Fonts.ubuntuRegular
    }
    
    static func applyComicsListAppearance(){
        ComicsListViewController.Appearance.noFoundItemsTitleFont = Fonts.ubuntuMedium
    }
}
