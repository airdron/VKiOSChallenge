//
//  CircledImageView.swift
//  vkChallenge
//
//  Created by Andrew Oparin on 10/11/2018.
//  Copyright © 2018 Andrew Oparin. All rights reserved.
//

import Foundation
import UIKit

class BaseImageView: UIImageView {
    
    var url: URL?
}

private extension UIImage {
    
    static func circledImage(image: UIImage) -> UIImage {
        guard image.size != .zero else { return UIImage() }
        let side = min(image.size.width, image.size.height)
        let x = -(image.size.width - side) / 2.0
        let y = -(image.size.height - side) / 2.0
        let origin = CGPoint(x: x, y: y)
        let size = CGSize(width: side, height: side)
        let imageFrame = CGRect(origin: origin, size: image.size)
        let pathFrame = CGRect(origin: CGPoint.zero, size: size)
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        defer {  UIGraphicsEndImageContext() }
        guard let context = UIGraphicsGetCurrentContext()
            else { return UIImage() }
        context.setBlendMode(.copy)
        context.setFillColor(UIColor.clear.cgColor)
        let path = UIBezierPath(ovalIn: pathFrame)
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        path.addClip()
        image.draw(in: imageFrame)
        let maskedImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        UIGraphicsEndImageContext()
        return maskedImage!
    }
}

class CircledImageView: BaseImageView {
    
    var borderLayer: CAShapeLayer
    
    init() {
        self.borderLayer = CAShapeLayer()
        super.init(frame: CGRect.zero)
        self.initialSetup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialSetup() {
        self.borderLayer.fillColor = UIColor.clear.cgColor
        self.layer.addSublayer(self.borderLayer)
        self.setNeedsLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.borderLayer.frame = self.bounds
        let path = UIBezierPath(ovalIn: self.bounds)
        self.borderLayer.path = path.cgPath
    }
    
    private static let queue = DispatchQueue(label: "maskedQueue", qos: .userInitiated)

    private weak var dispatchItem: DispatchWorkItem?
    override open var image: UIImage? {
        get {
            return super.image
        }
        set {
            guard let newValue = newValue else {
                super.image = nil
                return
            }
            
            self.dispatchItem?.cancel()
            let item = DispatchWorkItem {
                 let croppedImage = UIImage.circledImage(image: newValue)
                 DispatchQueue.main.async { super.image = croppedImage }
            }
            self.dispatchItem = item
            CircledImageView.queue.sync(execute: item)
        }
    }
}

extension BaseImageView {
    
    public func setImage(url: URL?) {
        guard self.url != url || url == nil else { return }
        self.url = url
        self.imageFrom(url: url)
    }
}
