//
//  ParallaxTableHeaderCutDrawer.swift
//  WallaMarvelUI
//
//  Created by Mario Plaza on 5/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import Foundation

public protocol ViewCutDrawer{
    func drawCut(height:Float, on view:UIView)
}

public extension ViewCutDrawer{
    func drawCut(height:Float, on view:UIView){
        let headerMaskLayer = CAShapeLayer()
        headerMaskLayer.fillColor = UIColor.black.cgColor
        view.layer.mask = headerMaskLayer
        
        let path = UIBezierPath()
        path.move(to: .zero)
        path.addLine(to: CGPoint(x: view.frame.width, y: 0))
        path.addLine(to: CGPoint(x: view.frame.width, y: view.frame.height))
        path.addLine(to: CGPoint(x: 0, y: view.frame.height - CGFloat(height)))
        
        headerMaskLayer.path = path.cgPath
    }
}
