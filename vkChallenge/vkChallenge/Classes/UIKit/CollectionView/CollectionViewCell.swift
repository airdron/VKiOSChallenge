//
//  CollectionViewCell.swift
//  vkChallenge
//
//  Created by Andrew Oparin on 10/11/2018.
//  Copyright © 2018 Andrew Oparin. All rights reserved.
//

import Foundation
import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    typealias ViewModelType = CollectionCellViewModel
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupInitialState()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupInitialState()
    }
    
    func setupInitialState() {
        self.initialSetup()
    }
    
    func initialSetup() {
        
    }
    
    func configure(viewModel: ViewModelType) {
        
    }
}
