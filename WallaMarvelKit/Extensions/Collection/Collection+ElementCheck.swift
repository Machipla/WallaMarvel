//
//  Collection+ElementCheck.swift
//  WallaMarvelAPI
//
//  Created by Mario Chinchilla on 29/5/18.
//

import Foundation

public extension Collection{
    func allConforms(to check:((Element)->Bool)) -> Bool {
        for singleElement:Element in self{
            if(!check(singleElement)){
                return false;
            }
        }
    
        return true;
    }
    
    func anyConforms(to check:((Element) -> Bool)) -> Bool{
        return first(where: check) != nil
    }
    
    func firstOfType<ElementType>() -> ElementType?{
        return first(where: { $0 is ElementType }) as? ElementType
    }
}
