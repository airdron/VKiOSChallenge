//
//  String.swift
//  vkChallenge
//
//  Created by Andrew Oparin on 10/11/2018.
//  Copyright © 2018 Andrew Oparin. All rights reserved.
//

import Foundation
import UIKit

public extension NSAttributedString {
    
    func height(width: CGFloat) -> CGFloat {
        let boundingRect = self.boundingRect(with: CGSize(width: width, height: CGFloat.greatestFiniteMagnitude),
                                             options: .usesLineFragmentOrigin,
                                             context: nil)
        let height = ceil(boundingRect.height)
        return height
    }
    
    func width(height: CGFloat) -> CGFloat {
        let boundingRect = self.boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: height),
                                             options: .usesLineFragmentOrigin,
                                             context: nil)
        let width = ceil(boundingRect.width)
        return width
    }
}
