//
//  SpinnerView.swift
//  WallaMarvelUI
//
//  Created by Mario Plaza on 4/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import Foundation
import IBAnimatable
import WallaMarvelKit

public final class SpinnerView: UIView{
    
    public var hidesWhenStop:Bool = true
    public var isAnimating:Bool{
        get{
            return imageView.layer.animationKeys()?.isEmpty ?? true
        }
        set{
            if newValue{
                startAnimating()
            }else{
                stopAnimating()
            }
        }
    }
    
    public let imageView:AnimatableImageView = {
        let imageView = AnimatableImageView(image: nil)
        imageView.configureAnimatableProperties()
        imageView.isHidden = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    public let images:[UIImage] = {
        let selfBundle = Bundle(for: SpinnerView.self)
        return [UIImage(named: "ic_black_panther_colored", in: selfBundle)!,
                UIImage(named: "ic_black_widow_colored", in: selfBundle)!,
                UIImage(named: "ic_cap_america_colored", in: selfBundle)!,
                UIImage(named: "ic_cap_marvel_colored", in: selfBundle)!,
                UIImage(named: "ic_dr_strange_colored", in: selfBundle)!,
                UIImage(named: "ic_groot_colored", in: selfBundle)!,
                UIImage(named: "ic_heimdall_colored", in: selfBundle)!,
                UIImage(named: "ic_hulk_colored", in: selfBundle)!,
                UIImage(named: "ic_iron_man_colored", in: selfBundle)!,
                UIImage(named: "ic_loki_colored", in: selfBundle)!,
                UIImage(named: "ic_rocket_raccoon_colored", in: selfBundle)!,
                UIImage(named: "ic_spiderman_colored", in: selfBundle)!,
                UIImage(named: "ic_thanos_colored", in: selfBundle)!]
    }()
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addSubview(imageView)
        imageView.frame = frame
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        imageView.frame = frame
    }
    
    public convenience init(){
        self.init(frame: CGRect(x: 0, y:0, width:50, height:50))
    }
    
    
    public override func didMoveToWindow() {
        super.didMoveToWindow()
        
        if isAnimating{
            stopAnimating()
            startAnimating()
        }
    }
    
    public func startAnimating(){
        startAnimationIterations()
    }
    
    public func stopAnimating(){
        imageView.layer.removeAllAnimations()
        imageView.isHidden = hidesWhenStop
    }
}

private extension SpinnerView{
    func startAnimationIterations(){
        imageView.isHidden = false
        
        imageView.image = randomImage()
        imageView.delay(0.8)
            .then(.pop(repeatCount: 1), duration: 0.4, timingFunction: .easeInCirc)
            .completion(startAnimationIterations)
    }
    
    func randomImage() -> UIImage{
        let index = Int.random(in: images.fullRange)
        return images[index]
    }
}
