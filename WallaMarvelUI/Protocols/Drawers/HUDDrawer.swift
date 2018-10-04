//
//  HUDDrawer.swift
//  WallaMarvelUI
//
//  Created by Mario Plaza on 3/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import Foundation
import JGProgressHUD

public protocol HUDDrawer{
    var progressViewParentView:UIView {get}
    
    @discardableResult
    func drawProgressHUD() -> UIView
    func hideProgressHUD()
    
    @discardableResult
    func drawSuccessHUD(dismissAfter delay:TimeInterval) -> UIView
    
    @discardableResult
    func drawErrorHUD(_ error:Error) -> UIView
    @discardableResult
    func drawErrorHUD(_ error:Error, dismissAfter delay:TimeInterval) -> UIView
}

public extension HUDDrawer{
    @discardableResult
    func drawProgressHUD() -> UIView{
        let HUD = templateHUD
        HUD.indicatorView = JGProgressHUDIndicatorView(contentView: SpinnerView())
        HUD.show(in: progressViewParentView, animated: true)
        return HUD
    }
    
    func hideProgressHUD(){
        guard let presentedHUD = JGProgressHUD.allProgressHUDs(in: progressViewParentView).first else { return }
        presentedHUD.dismiss(animated: true)
    }
    
    @discardableResult
    func drawSuccessHUD(dismissAfter delay:TimeInterval) -> UIView{
        let HUD = templateHUD
        HUD.indicatorView = JGProgressHUDSuccessIndicatorView()
        HUD.show(in: progressViewParentView, animated: true)
        HUD.dismiss(afterDelay: delay, animated: true)
        return HUD
    }
    
    @discardableResult
    func drawErrorHUD(_ error:Error) -> UIView{
        let HUD = templateHUD
        HUD.indicatorView = JGProgressHUDErrorIndicatorView()
        HUD.detailTextLabel.text = error.localizedDescription
        HUD.show(in: progressViewParentView, animated: true)
        return HUD
    }
    
    @discardableResult
    func drawErrorHUD(_ error:Error, dismissAfter delay:TimeInterval) -> UIView{
        let HUD = drawErrorHUD(error) as! JGProgressHUD
        HUD.dismiss(afterDelay: delay, animated: true)
        return HUD
    }
}

public extension HUDDrawer where Self: UIViewController{
    var progressViewParentView:UIView{ return view }
}

private extension HUDDrawer{
    var templateHUD:JGProgressHUD{
        let HUD = JGProgressHUD(style: .extraLight)
        HUD.animation = JGProgressHUDFadeZoomAnimation()
        HUD.shadow = JGProgressHUDShadow(color: .black, offset: CGSize(width: 2, height: 2), radius: 2, opacity: 0.7)
        return HUD
    }
}
