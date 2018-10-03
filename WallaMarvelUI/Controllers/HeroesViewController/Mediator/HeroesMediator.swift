//
//  HeroesMediator.swift
//  WallaMarvel
//
//  Created Mario Plaza on 3/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import UIKit
import WallaMarvelAPI

final class HeroesMediator {
    var presenter: HeroesPresenterProtocol!
    var delegateCaller: HeroesDelegateCallerProtocol!
    
    private var currentCursor = Cursor()
}

extension HeroesMediator: HeroesMediatorProtocol{
    func reloadData(){
        API.Characters.Get.all(cursor: currentCursor).then{ result in
                
        }.catch { error in
            
        }.always {
                
        }
    }
}
