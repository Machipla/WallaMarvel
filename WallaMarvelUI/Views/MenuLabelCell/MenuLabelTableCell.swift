//
//  MenuLabelTableCell.swift
//  PetSpotCoreUI
//
//  Created by Mario Plaza on 19/9/18.
//  Copyright © 2018 Machipla. All rights reserved.
//

import UIKit
import Eureka
import IBAnimatable

public final class MenuLabelTableCell: Cell<String>, CellType{
    @IBOutlet public weak var menuImageBackgroundView:AnimatableView!
    @IBOutlet public weak var menuImageView:AnimatableImageView!
    @IBOutlet public weak var menuLabel:UILabel!
    
    @IBOutlet public var menuImagePaddingConstraints:[NSLayoutConstraint]!
}
