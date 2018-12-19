//
//  TableViewCell.swift
//  vkChallenge
//
//  Created by Andrew Oparin on 09/11/2018.
//  Copyright © 2018 Andrew Oparin. All rights reserved.
//

import Foundation
import UIKit

class TableViewCell: UITableViewCell {
    
    typealias ViewModelType = TableCellViewModel
    
    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.initialSetup()
        self.setupConstraints()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialSetup()
        self.setupConstraints()
    }
    
    func initialSetup() {
        self.selectionStyle = .none
    }
    
    func configure(viewModel: ViewModelType) {
        
    }
    
    func willSelect() {
        
    }
    
    func didSelect() {
        
    }
    
    func setupConstraints() {
        
    }
    
    class func height(for viewModel: ViewModelType,
                           tableView: UITableView) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
}
