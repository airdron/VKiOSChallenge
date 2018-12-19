//
//  Button.swift
//  vkChallenge
//
//  Created by Andrew Oparin on 10/11/2018.
//  Copyright © 2018 Andrew Oparin. All rights reserved.
//

import Foundation
import UIKit

class Button: Control {
    
    private lazy var titleLabel = UILabel()
    
    var text: NSAttributedString? {
        didSet {
            self.titleLabel.attributedText = self.text
            self.invalidateIntrinsicContentSize()
        }
    }
    
    override func initialSetup() {
        super.initialSetup()
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.titleLabel)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        self.titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
    }
    
    override var isHighlighted: Bool {
        didSet {
            if self.isHighlighted {
                self.titleLabel.alpha = 0.5
            } else {
                self.titleLabel.alpha = 1.0
            }
        }
    }
    
    override var intrinsicContentSize: CGSize {
        let titleHeight: CGFloat = self.text?.height(width: CGFloat.greatestFiniteMagnitude) ?? 0
        let titleWidth: CGFloat = self.text?.width(height: titleHeight) ?? 0
        return CGSize(width: titleWidth, height: titleHeight)
    }
}
