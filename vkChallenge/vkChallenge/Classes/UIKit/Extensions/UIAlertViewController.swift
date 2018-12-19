//
//  UIAlertViewController.swift
//  vkChallenge
//
//  Created by Andrew Oparin on 09/11/2018.
//  Copyright © 2018 Andrew Oparin. All rights reserved.
//

import Foundation
import UIKit

extension UIAlertController {
    
    static let defaultErrorTitle: String = "Error"
    static let defaultWaitingTitle: String = "Идет проверка"
    
    static func errorAlertController(_ error: Error, title: String = UIAlertController.defaultErrorTitle) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: error.localizedDescription, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "OK", style: .cancel) { [weak alertController] _ in
            alertController?.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(dismissAction)
        return alertController
    }
    
    static func waitingAlert(title: String = UIAlertController.defaultWaitingTitle) -> UIAlertController {
        let alertController = UIAlertController(title: "", message: title, preferredStyle: .alert)
        return alertController
    }
    
}
