//
//  AboutMediatorProtocol.swift
//  WallaMarvel
//
//  Created Mario Plaza on 7/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import UIKit

protocol AboutMediatorProtocol: class{
    func dismissDone()
    func webWillBePresented()
    func webDismissed()
    
    
    func myLinkedInTapped()
    func myGithubTapped()
    func wallapopTapped()
    func marvelTapped()
    func iconsTapped()
}
