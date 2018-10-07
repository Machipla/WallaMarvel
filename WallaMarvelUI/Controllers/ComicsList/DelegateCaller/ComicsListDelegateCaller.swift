//
//  ComicsListDelegateCaller.swift
//  WallaMarvel
//
//  Created Mario Plaza on 6/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import UIKit
import WallaMarvelAPI

final class ComicsListDelegateCaller{
    weak var attachedView: ComicsListViewController!
}

extension ComicsListDelegateCaller: ComicsListDelegateCallerProtocol {
    func callDelegateForComicsSelected(_ comics:[Comic]){
        attachedView.delegate?.comicsListViewController(attachedView, hasSelected: comics)
    }
}
