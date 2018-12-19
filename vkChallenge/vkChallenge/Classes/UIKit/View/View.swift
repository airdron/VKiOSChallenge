//
//  View.swift
//  vkChallenge
//
//  Created by Andrew Oparin on 10/11/2018.
//  Copyright © 2018 Andrew Oparin. All rights reserved.
//

import Foundation
import UIKit

class View: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupInitialState()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupInitialState()
    }
    
    func initialSetup() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupInitialState() {
        self.initialSetup()
        self.setupConstraints()
    }
    
    func setupConstraints() {
        
    }
}
