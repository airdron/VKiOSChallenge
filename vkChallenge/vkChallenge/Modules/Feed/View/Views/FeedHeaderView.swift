//
//  FeedHeaderView.swift
//  vkChallenge
//
//  Created by Andrew Oparin on 10/11/2018.
//  Copyright © 2018 Andrew Oparin. All rights reserved.
//

import Foundation
import UIKit

class FeedHeaderView: View {
    
    static let contentHeight: CGFloat = 58
    
    private lazy var imageView = CircledImageView()
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Color.postText.value
        label.font = CustomFont.author.font
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Color.counterText.value
        label.font = CustomFont.date.font
        return label
    }()

    override func initialSetup() {
        super.initialSetup()
        self.translatesAutoresizingMaskIntoConstraints = false
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.imageView)
        self.addSubview(self.titleLabel)
        self.addSubview(self.subtitleLabel)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        self.imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 12).isActive = true
        self.imageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12).isActive = true
        self.imageView.widthAnchor.constraint(equalToConstant: 36).isActive = true
        self.imageView.heightAnchor.constraint(equalToConstant: 36).isActive = true
        
        self.titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 14).isActive = true
        self.titleLabel.leftAnchor.constraint(equalTo: self.imageView.rightAnchor, constant: 10).isActive = true
        self.titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true

        self.subtitleLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 1).isActive = true
        self.subtitleLabel.leftAnchor.constraint(equalTo: self.imageView.rightAnchor, constant: 10).isActive = true
        self.subtitleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
    }
    
    func configure(imageUrl: URL?, title: String, subtitle: String) {
        self.imageView.setImage(url: imageUrl)
        self.titleLabel.text = title
        self.subtitleLabel.text = subtitle
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: FeedHeaderView.contentHeight)
    }
}
