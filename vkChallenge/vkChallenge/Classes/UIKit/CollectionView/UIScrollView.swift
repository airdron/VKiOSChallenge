//
//  UIScrollView.swift
//  vkChallenge
//
//  Created by Andrew Oparin on 11/11/2018.
//  Copyright © 2018 Andrew Oparin. All rights reserved.
//

import Foundation
import UIKit

extension UIScrollView {
    
    static var bottomActivityIndicatorViewTag: Int { return Int.max - 1 }
    
    var isApproachingToBottom: Bool {
        let currentOffset = self.contentOffset.y
        let maximumOffset = self.contentSize.height - self.frame.size.height
        let deltaOffset = maximumOffset - currentOffset
        return deltaOffset <= 400
    }
    
    func bottomActivityIndicator(show: Bool, style: UIActivityIndicatorView.Style = .gray) {
        
        let heightIndicator: CGFloat = 40
        var activityIndicator: UIActivityIndicatorView? = self.viewWithTag(UIScrollView.bottomActivityIndicatorViewTag) as? UIActivityIndicatorView
        if show {
            if activityIndicator == nil {
                self.contentInset.bottom += heightIndicator
                
                activityIndicator = UIActivityIndicatorView(style: style)
                activityIndicator?.hidesWhenStopped = true
                activityIndicator?.tag = UIScrollView.bottomActivityIndicatorViewTag
                activityIndicator?.startAnimating()
                
                guard let activityIndicator = activityIndicator else { return }
                
                self.addSubview(activityIndicator)
                activityIndicator.frame.origin.x = 0
                activityIndicator.frame.origin.y = self.contentSize.height
                activityIndicator.frame.size.width = self.frame.width
                activityIndicator.frame.size.height = heightIndicator
            }
        } else {
            if activityIndicator != nil {
                self.contentInset.bottom -= heightIndicator
                activityIndicator?.removeFromSuperview()
            }
        }
    }
    
    func scrollToBottom(animated: Bool) {
        if self.contentSize.height < self.bounds.size.height { return }
        let bottomOffset = CGPoint(x: 0, y: self.contentSize.height - self.bounds.size.height)
        self.setContentOffset(bottomOffset, animated: animated)
    }
}
