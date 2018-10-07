//
//  ComicsListViewControllerDelegate.swift
//  WallaMarvel
//
//  Created Mario Plaza on 6/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import UIKit
import WallaMarvelAPI

public protocol ComicsListViewControllerDelegate: class {
    func comicsListViewController(_ controller:ComicsListViewController, hasSelected comics:[Comic])
}

public extension ComicsListViewControllerDelegate {
    func comicsListViewController(_ controller:ComicsListViewController, hasSelected comics:[Comic]){}
}
