//
//  FeedActionsView.swift
//  vkChallenge
//
//  Created by Andrew Oparin on 10/11/2018.
//  Copyright © 2018 Andrew Oparin. All rights reserved.
//

import Foundation
import UIKit

class FeedActionsView: View {
    
    static let contentHeight: CGFloat = 43
    
    override func initialSetup() {
        super.initialSetup()
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.likesImageView)
        self.addSubview(self.commentsImageView)
        self.addSubview(self.repostsImageView)
        self.addSubview(self.viewsImageView)
        self.addSubview(self.likesLabel)
        self.addSubview(self.commentsLabel)
        self.addSubview(self.repostsLabel)
        self.addSubview(self.viewsLabel)
    }
    
    private lazy var likesImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = #imageLiteral(resourceName: "Like_outline_24").withRenderingMode(.alwaysTemplate)
        imageView.tintColor = Color.counterIcon.value
        return imageView
    }()
    
    private lazy var commentsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = #imageLiteral(resourceName: "Comment_outline_24").withRenderingMode(.alwaysTemplate)
        imageView.tintColor = Color.counterIcon.value
        return imageView
    }()
    
    private lazy var repostsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = #imageLiteral(resourceName: "Share_outline_24").withRenderingMode(.alwaysTemplate)
        imageView.tintColor = Color.counterIcon.value
        return imageView
    }()
    
    private lazy var viewsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = #imageLiteral(resourceName: "View_20").withRenderingMode(.alwaysTemplate)
        imageView.tintColor = Color.viewsIcon.value
        return imageView
    }()
    
    private lazy var likesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Color.counterText.value
        label.font = CustomFont.countersText.font
        return label
    }()
    
    private lazy var commentsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Color.counterText.value
        label.font = CustomFont.countersText.font
        return label
    }()
    
    private lazy var repostsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Color.counterText.value
        label.font = CustomFont.countersText.font
        return label
    }()
    
    private lazy var viewsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Color.viewsText.value
        label.font = CustomFont.viewsText.font
        return label
    }()
    
    override func setupConstraints() {
        super.setupConstraints()
        self.likesImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.commentsImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.repostsImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.viewsImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.likesLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.commentsLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.repostsLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.viewsLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true

        self.likesLabel.widthAnchor.constraint(equalToConstant: 60).isActive = true
        self.commentsLabel.widthAnchor.constraint(equalToConstant: 60).isActive = true
        self.repostsLabel.widthAnchor.constraint(equalToConstant: 60).isActive = true
        self.viewsLabel.widthAnchor.constraint(equalToConstant: 32).isActive = true

        self.likesLabel.leftAnchor.constraint(equalTo: self.likesImageView.rightAnchor, constant: 5).isActive = true
        self.commentsLabel.leftAnchor.constraint(equalTo: self.commentsImageView.rightAnchor, constant: 5).isActive = true
        self.repostsLabel.leftAnchor.constraint(equalTo: self.repostsImageView.rightAnchor, constant: 5).isActive = true
        
        self.likesImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 18).isActive = true
        self.commentsImageView.leftAnchor.constraint(equalTo: self.likesLabel.rightAnchor).isActive = true
        self.repostsImageView.leftAnchor.constraint(equalTo: self.commentsLabel.rightAnchor).isActive = true

        self.viewsImageView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -37).isActive = true
        self.viewsLabel.leftAnchor.constraint(equalTo: self.viewsImageView.rightAnchor, constant: 5).isActive = true
    }
    
    func configure(likes: String, comments: String, reposts: String, views: String?) {
        self.likesLabel.text = likes
        self.commentsLabel.text = comments
        self.repostsLabel.text = reposts
        if let _ = views {
            self.viewsImageView.isHidden = false
            self.viewsLabel.isHidden = false
        } else {
            self.viewsImageView.isHidden = true
            self.viewsLabel.isHidden = true
        }
        self.viewsLabel.text = views
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: FeedActionsView.contentHeight)
    }
}
