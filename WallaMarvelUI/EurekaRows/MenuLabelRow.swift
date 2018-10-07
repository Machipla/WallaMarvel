//
//  MenuLabelRow.swift
//  PetSpotCoreUI
//
//  Created by Mario Plaza on 19/9/18.
//  Copyright © 2018 Machipla. All rights reserved.
//

import Foundation
import Eureka

public final class MenuLabelRow: Row<MenuLabelTableCell>, RowType{
    
    public var menuColor:UIColor?{
        get{ return cell.menuImageBackgroundView.backgroundColor }
        set{ cell.menuImageBackgroundView.backgroundColor = newValue }
    }
    
    public var menuImage:UIImage?{
        get{ return cell.menuImageView.image }
        set{ cell.menuImageView.image = newValue }
    }
    
    public var menuTitle:String?{
        get { return cell.menuLabel.text }
        set { cell.menuLabel.text = newValue }
    }
    
    public required init(tag: String?) {
        super.init(tag: tag)
        cellProvider = CellProvider<MenuLabelTableCell>(nibName: Cell.nibName, bundle: Bundle(for: Cell.self))
    }
}
