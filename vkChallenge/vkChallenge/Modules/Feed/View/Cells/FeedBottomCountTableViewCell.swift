//
//  FeedBottomCountTableViewCell.swift
//  vkChallenge
//
//  Created by Andrew Oparin on 11/11/2018.
//  Copyright © 2018 Andrew Oparin. All rights reserved.
//

import Foundation
import UIKit

class FeedBottomCountTableViewCell: TableViewCell {

    static let contentHeight: CGFloat = 40
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Color.records.value
        label.font = CustomFont.records.font
        return label
    }()
    
    override func initialSetup() {
        super.initialSetup()
        self.backgroundColor = UIColor.clear
        self.contentView.backgroundColor = UIColor.clear
        self.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(self.titleLabel)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        self.titleLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        self.titleLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
    }
    
    override func configure(viewModel: TableViewCell.ViewModelType) {
        let viewModel = viewModel as! FeedBottomCountTableCellViewModel
        self.titleLabel.text = viewModel.count
    }
    
    override class func height(for viewModel: ViewModelType,
                               tableView: UITableView) -> CGFloat {
        return FeedBottomCountTableViewCell.contentHeight
    }
}

struct FeedBottomCountTableCellViewModel: TableCellViewModel {
    
    var cellType: TableViewCell.Type { return FeedBottomCountTableViewCell.self }
    var count: String
}
