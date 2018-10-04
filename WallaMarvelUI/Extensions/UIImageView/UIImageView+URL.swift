//
//  UIImageView+URL.swift
//  WallaMarvelUI
//
//  Created by Mario Plaza on 04/10/18.
//

import Foundation
import UIKit
import Alamofire
import AlamofireImage

public extension UIImageView{
    public func setImage(
        withURL url: URL?,
        placeholderImage: UIImage? = nil,
        filter: ImageFilter? = nil,
        progress: ImageDownloader.ProgressHandler? = nil,
        progressQueue: DispatchQueue = DispatchQueue.main,
        imageTransition: ImageTransition = .noTransition,
        runImageTransitionIfCached: Bool = false,
        completion: ((DataResponse<UIImage>) -> Void)? = nil)
    {
        if let url = url{
            af_setImage(withURL: url,
                placeholderImage: placeholderImage,
                filter: filter,
                progress: progress,
                progressQueue: progressQueue,
                imageTransition: imageTransition,
                runImageTransitionIfCached: runImageTransitionIfCached,
                completion: completion
            )
        }else{
            image = placeholderImage
        }
    }
}
