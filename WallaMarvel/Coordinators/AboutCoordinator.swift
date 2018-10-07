//
//  AboutCoordinator.swift
//  WallaMarvel
//
//  Created by Mario Plaza on 7/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import Foundation
import UIKit
import WallaMarvelAPI
import WallaMarvelUI

final class AboutCoordinator: Coordinator, Startable{
    var childs = [Coordinator]()
    
    private(set) weak var fromController:UIViewController!
    private(set) weak var aboutController:AboutViewController?
    
    init(fromController:UIViewController){
        self.fromController = fromController
    }
    
    func start(){
        let aboutController = AboutViewController()
        
        fromController.present(aboutController, animated: true, completion: nil)
        self.aboutController = aboutController
    }
}
