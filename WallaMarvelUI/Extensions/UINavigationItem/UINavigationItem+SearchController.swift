//
//  UINavigationItem+SearchController.swift
//  WallaMarvelUI
//
//  Created by Mario Plaza on 4/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import Foundation

public extension UINavigationItem{
    fileprivate struct AssociatedKeys{
        static var CompatibilitySearchController = "CompatibilitySearchControllerAssociatedKey"
        
        private init(){}
    }
    
    
    /// Compatibility variable  from iOS 8 and beyond in order to provide the same functionality as 'searchController' for iOS 11
    @available(iOS 8.0, *)
    var searchingController:UISearchController?{
        get{
            if #available(iOS 11.0, *){
                return searchController
            }else{
                return objc_getAssociatedObject(self, &AssociatedKeys.CompatibilitySearchController) as? UISearchController
            }
        }
        set{
            if #available(iOS 11.0, *){
                searchController = newValue
            }else{
                if newValue != nil{
                    titleView = newValue?.searchBar
                }else if let navBarSearchView = titleView as? UISearchBar, navBarSearchView === searchingController?.searchBar{
                    navBarSearchView.removeFromSuperview()
                    titleView = nil
                }
                
                objc_setAssociatedObject(self, &AssociatedKeys.CompatibilitySearchController, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
}
