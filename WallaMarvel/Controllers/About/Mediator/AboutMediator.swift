//
//  AboutMediator.swift
//  WallaMarvel
//
//  Created Mario Plaza on 7/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import UIKit

final class AboutMediator {
    var presenter: AboutPresenterProtocol!
    var delegateCaller: AboutDelegateCallerProtocol!
}

extension AboutMediator: AboutMediatorProtocol{
    func dismissDone(){
        delegateCaller.callDelegateForDismissDone()
    }
    
    func myLinkedInTapped(){
        presenter.display(AboutURLs.linkedIn)
    }
    
    func myGithubTapped(){
        presenter.display(AboutURLs.github)
    }
    
    func wallapopTapped(){
        presenter.display(AboutURLs.wallapop)
    }
    
    func marvelTapped(){
        presenter.display(AboutURLs.marvelAPI)
    }
    
    func iconsTapped(){
        presenter.display(AboutURLs.icons8)
    }
}
