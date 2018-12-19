//
//  Font.swift
//  vkChallenge
//
//  Created by Andrew Oparin on 10/11/2018.
//  Copyright © 2018 Andrew Oparin. All rights reserved.
//

import Foundation
import UIKit

enum CustomFont {
    
    case author
    case date
    case postText
    case viewsText
    case searchPlaceholder
    case searchText
    case expandText
    case countersText
    case records
    
    var font: UIFont {
        switch self {
        case .author:
            return UIFont.systemFont(ofSize: 14, weight: .medium)
        case .date:
            return UIFont.systemFont(ofSize: 12, weight: .regular)
        case .postText:
            return UIFont.systemFont(ofSize: 15, weight: .regular)
        case .expandText:
            return UIFont.systemFont(ofSize: 15, weight: .regular)
        case .viewsText:
            return UIFont.systemFont(ofSize: 14, weight: .regular)
        case .searchPlaceholder:
            return UIFont.systemFont(ofSize: 16, weight: .regular)
        case .searchText:
            return UIFont.systemFont(ofSize: 16, weight: .regular)
        case .countersText:
            return UIFont.systemFont(ofSize: 14, weight: .medium)
        case .records:
            return UIFont.systemFont(ofSize: 13, weight: .regular)
        }
    }
    
    var color: UIColor {
        switch self {
        case .author:
            return Color.postText.value
        case .date:
            return Color.counterText.value
        case .postText:
            return Color.postText.value
        case .expandText:
            return Color.expandText.value
        case .viewsText:
            return Color.viewsText.value
        case .searchPlaceholder:
            return Color.counterText.value
        case .searchText:
            return Color.postText.value
        case .countersText:
            return Color.counterText.value
        case .records:
            return Color.records.value
        }
    }
    
    var lineHeight: CGFloat {
        switch self {
        case .author:
            return 16
        case .date:
            return 14
        case .postText:
            return 22
        case .expandText:
            return 22
        case .viewsText:
            return 16
        case .searchPlaceholder:
            return 20
        case .searchText:
            return 20
        case .countersText:
            return 16
        case .records:
            return 16
        }
    }
    
    var lineHeightMultiple: CGFloat {
        return self.lineHeight / self.font.lineHeight
    }
    
    var paragraphStyle: NSMutableParagraphStyle {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = self.lineHeightMultiple
        return paragraphStyle
    }
    
    var attributes: [NSAttributedString.Key: Any] {
        return [NSAttributedString.Key.foregroundColor : self.color,
                NSAttributedString.Key.font : self.font]
    }
    
    var attributesWithParagraph: [NSAttributedString.Key: Any] {
        return [NSAttributedString.Key.foregroundColor : self.color,
                NSAttributedString.Key.font : self.font,
                NSAttributedString.Key.paragraphStyle: self.paragraphStyle]
    }
}
