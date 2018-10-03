//
//  Coordinator.swift
//  WallaMarvel
//
//  Created by Mario Chinchilla on 3/10/18.
//

import Foundation

protocol Coordinator: class{
    var childs:[Coordinator] {get set}
    
    func addChild(_ child:Coordinator)
    func removeChild(_ child:Coordinator)
    func startChild(_ child:Coordinator & Startable)
}

extension Coordinator{
    func addChild(_ child:Coordinator){
        childs.append(child)
    }
    
    func removeChild(_ child:Coordinator){
        childs.removeAll(where: { return $0 === child })
    }
    
    func startChild(_ child:Coordinator & Startable){
        addChild(child)
        child.start()
    }
}
