//
//  Color.swift
//  vkChallenge
//
//  Created by Andrew Oparin on 10/11/2018.
//  Copyright © 2018 Andrew Oparin. All rights reserved.
//

import Foundation
import UIKit

enum Color {
    
    case postText
    case counterText
    case counterIcon
    case viewsIcon
    case viewsText
    case searchIcon
    case searchBackground
    case expandText
    case searchBar
    case records
    
    var value: UIColor {
        switch self {
        case .postText:
            return UIColor(red: 0.17, green: 0.18, blue: 0.19, alpha: 1)
        case .counterText:
            return UIColor(red: 0.5, green: 0.55, blue: 0.6, alpha: 1)
        case .counterIcon:
            return UIColor(red: 0.6, green: 0.64, blue: 0.68, alpha: 1)
        case .viewsIcon:
            return UIColor(red: 0.77, green: 0.78, blue: 0.8, alpha: 1)
        case .viewsText:
            return UIColor(red: 0.66, green: 0.68, blue: 0.7, alpha: 1)
        case .searchIcon:
            return UIColor(red: 0.67, green: 0.68, blue: 0.7, alpha: 1)
        case .searchBackground:
            return UIColor(red: 0, green: 0.11, blue: 0.24, alpha: 0.06)
        case .expandText:
            return UIColor(red: 0.32, green: 0.51, blue: 0.72, alpha: 1.0)
        case .searchBar:
            return UIColor(red: 0, green: 0.11, blue: 0.24, alpha: 0.06)
        case .records:
            return UIColor(red: 0.56, green: 0.58, blue: 0.6, alpha: 1)
        
        }
    }
}
