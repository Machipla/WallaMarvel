//
//  UIView+Load.swift
//  WallaMarvelUI
//
//  Created by Mario Plaza on 4/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import Foundation
import WallaMarvelAPI

public extension UIView {
    class var nibName: String {
        return "\(self)".components(separatedBy: ".").first ?? ""
    }
    
    class var nib: UINib? {
        let bundle = Bundle(for: self)
        if let _ = bundle.path(forResource: nibName, ofType: "nib") {
            return UINib(nibName: nibName, bundle: bundle)
        } else {
            return nil
        }
    }
    
    class var bundle:Bundle? {
        return Bundle(for: self)
    }
}

// MARK: - External Nib loading
public extension UIView{
    
    //// Methods ////
    class func fromNib() -> Self? {
        return fromNib(nil, on: nil);
    }
    
    class func fromNib(_ nibName:String?) -> Self?{
        return fromNib(nibName, on: Bundle.main)
    }
    
    class func fromNib(on bundle:Bundle?) -> Self?{
        return fromNib(nil, on: bundle)
    }
    
    class func fromNib(_ nibName:String?,on bundle:Bundle?) -> Self?{
        let name = nibName != nil ? nibName! : self.nibName
        let loadingBundle = bundle != nil ? bundle! : self.bundle
        let nib = UINib(nibName: name, bundle: loadingBundle)
        let nibViews = nib.instantiate(withOwner: nil, options: nil)
        
        return nibViews.firstOfType()
    }
}

// MARK: - Instance Nib binding
public extension UIView{
    
    /// Loads an instantiated view from a nib.
    ///
    /// - Note: The File's owner of the nib must be of the same type as the view calling this method. This method throws an exception if no view could be loaded.
    /// - Parameters:
    ///   - nibName: Nib name from which to load and bind the view
    ///   - bundle: Bundle in which search for the nib
    @discardableResult
    func loadFromNibAsOwner(_ nibName:String?,on bundle:Bundle?) -> UIView{
        let name = nibName != nil ? nibName! : type(of: self).nibName
        let loadingBundle = bundle != nil ? bundle! : Bundle.main
        let nib = UINib(nibName: name, bundle: loadingBundle)
        let nibViews = nib.instantiate(withOwner: self, options: nil)
        
        guard let nibView:UIView = nibViews.firstOfType() else { fatalError("No view could be loaded. Is the File's owner type in nib, the same as the view calling this method?") }
        
        addSubview(nibView)
        return nibView
    }
}
