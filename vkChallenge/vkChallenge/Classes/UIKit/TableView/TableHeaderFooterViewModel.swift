//
//  TableHeaderFooterViewModel.swift
//  vkChallenge
//
//  Created by Andrew Oparin on 09/11/2018.
//  Copyright © 2018 Andrew Oparin. All rights reserved.
//

import Foundation

protocol TableHeaderFooterViewModel {
    
    var viewType: TableHeaderFooterView.Type { get }
}
