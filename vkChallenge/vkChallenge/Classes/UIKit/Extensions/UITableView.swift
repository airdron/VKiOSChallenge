//
//  UITableView.swift
//  vkChallenge
//
//  Created by Andrew Oparin on 09/11/2018.
//  Copyright © 2018 Andrew Oparin. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    
    func register(cellClass: UITableViewCell.Type) {
        self.register(cellClass,
                      forCellReuseIdentifier: String(describing: cellClass))
    }
    
    func register(headerFooterViewClass: UITableViewHeaderFooterView.Type) {
        self.register(headerFooterViewClass,
                      forHeaderFooterViewReuseIdentifier: String(describing: headerFooterViewClass))
    }
}
