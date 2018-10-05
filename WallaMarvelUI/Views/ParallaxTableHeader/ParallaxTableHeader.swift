//
//  ParallaxTableHeader.swift
//  PetSpotCoreUI
//
//  Created by Mario Plaza on 20/9/18.
//  Copyright © 2018 Machipla. All rights reserved.
//

import UIKit

public final class ParallaxTableHeader: UIView {
    @IBOutlet public weak var imageView:UIImageView!
    @IBOutlet private weak var defaultHeightConstraint:NSLayoutConstraint!
    @IBOutlet private weak var heightConstraint:NSLayoutConstraint!
    
    public weak var delegate:ParallaxTableHeaderDelegate?
    public var height:CGFloat{
        get{ return defaultHeightConstraint.constant }
        set{
            defaultHeightConstraint.constant = newValue
            layoutIfNeeded()
        }
    }
    
    public func updateParallax(for tableView:UITableView){
        let offsetY = tableView.contentOffset.y + tableView.contentInset.top
        let clampedHeight = offsetY < 0 ? CGFloat(height) : CGFloat(height) - offsetY
        heightConstraint.constant = clampedHeight

        layoutIfNeeded()
    }
}

extension ParallaxTableHeader{
    @IBAction private func imageTapped(){
        delegate?.parallaxTableHeaderHasBeenTapped(self)
    }
}
