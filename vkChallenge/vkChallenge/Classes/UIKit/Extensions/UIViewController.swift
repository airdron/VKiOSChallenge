//
//  UIViewController.swift
//  vkChallenge
//
//  Created by Andrew Oparin on 09/11/2018.
//  Copyright © 2018 Andrew Oparin. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    var topLayoutEdge: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.view.safeAreaLayoutGuide.topAnchor
        } else {
            return self.topLayoutGuide.bottomAnchor
        }
    }
    
    var bottomLayoutEdge: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.view.safeAreaLayoutGuide.bottomAnchor
        } else {
            return self.bottomLayoutGuide.topAnchor
        }
    }
    
    var leftLayoutEdge: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.view.safeAreaLayoutGuide.leadingAnchor
        } else {
            return self.view.leadingAnchor
        }
    }
    
    var rightLayoutEdge: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.view.safeAreaLayoutGuide.trailingAnchor
        } else {
            return self.view.trailingAnchor
        }
    }
    
    var topLayoutEdgeInset: CGFloat {
        if #available(iOS 11.0, *) {
            return self.view.safeAreaInsets.top
        } else {
            return self.topLayoutGuide.length
        }
    }
    
    var bottomLayoutEdgeInset: CGFloat {
        if #available(iOS 11.0, *) {
            return self.view.safeAreaInsets.bottom
        } else {
            return self.bottomLayoutGuide.length
        }
    }
}

extension UIViewController {
    
    func showErrorAlert(_ error: Error) {
        self.present(UIAlertController.errorAlertController(error), animated: true, completion: nil)
    }
    
    func showWaitingAlert() -> UIAlertController {
        let alert = UIAlertController.waitingAlert()
        self.present(UIAlertController.waitingAlert(), animated: true, completion: nil)
        return alert
    }
}

extension UIViewController {
    
    func add(_ child: UIViewController) {
        self.addChild(child)
        self.view.addSubview(child.view)
        child.view.frame = self.view.bounds
        child.didMove(toParent: self)
    }
    func removeFromParentWithView() {
        guard self.parent != nil else {
            return
        }
        self.willMove(toParent: nil)
        self.removeFromParent()
        self.view.removeFromSuperview()
    }
}
