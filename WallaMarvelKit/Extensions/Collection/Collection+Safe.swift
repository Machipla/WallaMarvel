//
//  Collection+Safe.swift
//  Pods
//
//  Created by Mario Chinchilla on 04/10/18.
//

import Foundation

public extension Collection{
    
    /// Returns the element at the specified index iff it is within bounds, otherwise nil.
    public subscript (safe index: Index) -> Iterator.Element? {
        get{ return indices.contains(index) ? self[index] : nil }
    }
    
    public subscript(safe bounds:Range<Self.Index>) -> Self.SubSequence?{
        return self[safe:bounds.lowerBound...bounds.upperBound]
    }
    
    public subscript(safe bounds:ClosedRange<Self.Index>) -> Self.SubSequence?{
        guard !isEmpty else { return nil }
        
        let safeLowerBound = bounds.lowerBound >= startIndex ? bounds.lowerBound : startIndex
        let safeUpperBound = bounds.upperBound < endIndex ? bounds.upperBound : endIndex
        return self[safeLowerBound..<safeUpperBound]
    }
}
