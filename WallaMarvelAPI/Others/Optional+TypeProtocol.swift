//
//  Optional+TypeProtocol.swift
//  ADAppRater
//
//  Created by Mario Chinchilla on 22/11/17.
//

import Foundation

public protocol OptionalType {
    associatedtype Wrapped
    var optionalValue: Wrapped? { get }
}

extension Optional: OptionalType {
    public var optionalValue: Wrapped? { return self }
}
