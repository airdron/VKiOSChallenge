//
//  Dictionary.swift
//  vkChallenge
//
//  Created by Andrew Oparin on 10/11/2018.
//  Copyright © 2018 Andrew Oparin. All rights reserved.
//

import Foundation
import UIKit

extension Dictionary where Key == NSAttributedString.Key, Value == Any {
    
    func toDeprecatedAttributeDictionary() -> [String: Any] {
        var dict: [String: Any] = [:]
        self.keys.forEach {
            dict[$0.rawValue] = self[$0]
        }
        return dict
    }
    
    func colored(color: UIColor) -> [NSAttributedString.Key: Any] {
        var dict = self
        dict[NSAttributedString.Key.foregroundColor] = color
        return dict
    }
    
    func linking(string: String) -> [NSAttributedString.Key: Any] {
        var dict = self
        dict[NSAttributedString.Key.link] = string
        return dict
    }
    
    func underlying(color: UIColor) -> [NSAttributedString.Key: Any] {
        var dict = self
        dict[NSAttributedString.Key.underlineColor] = color
        dict[NSAttributedString.Key.underlineStyle] = 1
        
        return dict
    }
    
    func textAlignment(_ alignment: NSTextAlignment) -> [NSAttributedString.Key: Any] {
        var dict = self
        if let paragraphStyle = self[NSAttributedString.Key.paragraphStyle] as? NSParagraphStyle {
            
            let style: NSMutableParagraphStyle = paragraphStyle as! NSMutableParagraphStyle
            style.alignment = alignment
            dict[NSAttributedString.Key.paragraphStyle] = style
        } else {
            let style = NSMutableParagraphStyle()
            style.alignment = alignment
            dict[NSAttributedString.Key.paragraphStyle] = style
        }
        return dict
    }
    
    func make(string: String) -> NSAttributedString {
        return NSAttributedString(string: string, attributes: self)
    }
    
    func makeMutable(string: String) -> NSMutableAttributedString {
        return NSMutableAttributedString(attributedString: self.make(string: string))
    }
}
