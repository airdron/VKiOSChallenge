//
//  TableCellViewModel.swift
//  vkChallenge
//
//  Created by Andrew Oparin on 09/11/2018.
//  Copyright © 2018 Andrew Oparin. All rights reserved.
//

import Foundation
import UIKit

protocol TableCellViewModel {
    
    var cellType: TableViewCell.Type { get }
}

extension TableCellViewModel {
    
    var reuseIdentifier: String {
        return String(describing: self.cellType)
    }
}

protocol TableSectionViewModel {
    var cellModels: [TableCellViewModel] { get set }
    var headerViewModel: TableHeaderFooterViewModel? { get }
    var footerViewModel: TableHeaderFooterViewModel? { get }
}

struct DefaultTableSectionViewModel: TableSectionViewModel {
    
    var cellModels: [TableCellViewModel]
    var headerViewModel: TableHeaderFooterViewModel? = nil
    var footerViewModel: TableHeaderFooterViewModel? = nil
}
