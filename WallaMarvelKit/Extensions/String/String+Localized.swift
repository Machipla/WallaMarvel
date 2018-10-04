//
//  String+Localized.swift
//  WallaMarvelKit
//
//  Created by Mario Chinchilla on 04/10/18.
//

import Foundation

public extension String{
    func localized() -> String{
        return localized(on: Bundle.main)
    }
    
    func localized(params:CVarArg...) -> String{
        return String(format: self.localized(),arguments: params)
    }
    
    func localized(on bundle:Bundle) -> String{
        return NSLocalizedString(self, tableName: nil, bundle: bundle, value: "", comment: "")
    }
    
    func localized(on bundle:Bundle, params:CVarArg...) -> String{
        return String(format: self.localized(on: bundle), arguments: params)
    }
    
    func localized(onBundleFor thisClass:AnyClass) -> String{
        return localized(on: Bundle(for: thisClass))
    }
    
    func localized(onBundleFor thisClassInstance:AnyObject) -> String{
        return localized(on: Bundle(for: type(of: thisClassInstance)))
    }
}
