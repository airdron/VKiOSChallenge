//
//  FeedPhotoCollectionViewCell.swift
//  vkChallenge
//
//  Created by Andrew Oparin on 10/11/2018.
//  Copyright © 2018 Andrew Oparin. All rights reserved.
//

import Foundation
import UIKit

class FeedPhotoCollectionViewCell: CollectionViewCell {
        
    public lazy var contentImageView: BaseImageView = {
        let imageView = BaseImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = UIColor.white
        return imageView
    }()
    
    public override func initialSetup() {
        super.initialSetup()
        self.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(self.contentImageView)
        self.contentView.clipsToBounds = true
        self.contentView.backgroundColor = UIColor.white
        self.backgroundColor = UIColor.white
        self.setNeedsLayout()
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        let contentWidth = self.contentView.bounds.width
        let imageHeight = self.contentView.bounds.height
        self.contentImageView.frame.size = CGSize(width: contentWidth, height: imageHeight)
        self.contentImageView.frame.origin.x = 0
        self.contentImageView.frame.origin.y = 0
    }
}
