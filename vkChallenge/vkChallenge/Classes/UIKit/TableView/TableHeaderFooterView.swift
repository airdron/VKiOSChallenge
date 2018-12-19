//
//  TableHeaderFooterView.swift
//  vkChallenge
//
//  Created by Andrew Oparin on 09/11/2018.
//  Copyright © 2018 Andrew Oparin. All rights reserved.
//

import Foundation
import UIKit

class TableHeaderFooterView: UITableViewHeaderFooterView {
    
    typealias ViewModelType = TableHeaderFooterViewModel
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        initialSetup()
        self.setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialSetup()
        self.setupConstraints()
    }
    
    func initialSetup() {
        
    }
    
    func configure(viewModel: ViewModelType) {
        
    }
    
    func setupConstraints() {
        
    }
    
    class func height(for viewModel: ViewModelType, tableView: UITableView) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
}
