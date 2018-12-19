//
//  FeedTableViewCell.swift
//  vkChallenge
//
//  Created by Andrew Oparin on 10/11/2018.
//  Copyright © 2018 Andrew Oparin. All rights reserved.
//

import Foundation
import UIKit

class FeedTableViewCell: TableViewCell {
    
    static let contentSideOffset: CGFloat = 12
    static let containerSideOffset: CGFloat = 8

    private lazy var backImageView = UIImageView(image: #imageLiteral(resourceName: "CardWithShadow"))
    private lazy var containerView = UIView()
    
    private lazy var headerView = FeedHeaderView()
    private lazy var photosView = FeedPhotosView()
    private lazy var actionsView = FeedActionsView()

    private var textHeightConstraint: NSLayoutConstraint?
    private var viewModel: FeedTableCellViewModel?
    
    private var photosTopConstraintToExpandButton: NSLayoutConstraint?
    private var photosTopConstraintToText: NSLayoutConstraint?
    private var photosHeightConstraint: NSLayoutConstraint?

    private lazy var expandButton: Button = {
        let text = "Показать полностью..."
        let button = Button()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.text = CustomFont.expandText.attributesWithParagraph.make(string: text)
        button.addTarget(self, action: #selector(expandedTouch), for: .touchUpInside)
        return button
    }()
    
    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.textAlignment = .left
        textView.bounces = false
        textView.isScrollEnabled = false
        textView.isSelectable = true
        textView.isEditable = false
        textView.spellCheckingType = .no
        textView.textContainerInset = UIEdgeInsets.zero
        textView.textContainer.lineFragmentPadding = 0
        // TODO: performance problem
        //textView.dataDetectorTypes = [.link]
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    override func initialSetup() {
        super.initialSetup()
        self.backgroundColor = UIColor.clear
        self.contentView.backgroundColor = UIColor.clear
        self.backImageView.translatesAutoresizingMaskIntoConstraints = false
        self.containerView.translatesAutoresizingMaskIntoConstraints = false

        self.contentView.addSubview(self.backImageView)
        self.contentView.addSubview(self.containerView)
        self.containerView.addSubview(self.headerView)
        self.containerView.addSubview(self.textView)
        self.containerView.addSubview(self.expandButton)
        self.containerView.addSubview(self.photosView)
        self.containerView.addSubview(self.actionsView)
    }
    
    override class func height(for viewModel: ViewModelType,
                      tableView: UITableView) -> CGFloat {
        let viewModel = viewModel as! FeedTableCellViewModel
        return viewModel.height
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        self.backImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        self.backImageView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: -10).isActive = true
        self.backImageView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: 10).isActive = true
        self.backImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 12).isActive = true
        
        self.containerView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        self.containerView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: FeedTableViewCell.containerSideOffset).isActive = true
        self.containerView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -FeedTableViewCell.containerSideOffset).isActive = true
        self.containerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -12).isActive = true

        self.headerView.topAnchor.constraint(equalTo: self.containerView.topAnchor).isActive = true
        self.headerView.leftAnchor.constraint(equalTo: self.containerView.leftAnchor).isActive = true
        self.headerView.rightAnchor.constraint(equalTo: self.containerView.rightAnchor).isActive = true
        
        self.textView.topAnchor.constraint(equalTo: self.headerView.bottomAnchor).isActive = true
        self.textView.leftAnchor.constraint(equalTo: self.containerView.leftAnchor, constant: FeedTableViewCell.contentSideOffset).isActive = true
        self.textView.rightAnchor.constraint(equalTo: self.containerView.rightAnchor, constant: -FeedTableViewCell.contentSideOffset).isActive = true
        self.textHeightConstraint = self.textView.heightAnchor.constraint(equalToConstant: 0)
        
        self.expandButton.topAnchor.constraint(equalTo: self.textView.bottomAnchor).isActive = true
        self.expandButton.leftAnchor.constraint(equalTo: self.containerView.leftAnchor, constant: FeedTableViewCell.contentSideOffset).isActive = true
        
        self.photosTopConstraintToExpandButton = self.photosView.topAnchor.constraint(equalTo: self.expandButton.bottomAnchor,
                                                                                      constant: 6)
        self.photosTopConstraintToText = self.photosView.topAnchor.constraint(equalTo: self.textView.bottomAnchor,
                                                                              constant: 6)
        self.photosHeightConstraint = self.photosView.heightAnchor.constraint(equalToConstant: 0)
        self.photosHeightConstraint?.isActive = true
        self.photosView.leftAnchor.constraint(equalTo: self.containerView.leftAnchor).isActive = true
        self.photosView.rightAnchor.constraint(equalTo: self.containerView.rightAnchor).isActive = true
        self.actionsView.topAnchor.constraint(equalTo: self.photosView.bottomAnchor).isActive = true
        self.actionsView.leftAnchor.constraint(equalTo: self.containerView.leftAnchor).isActive = true
        self.actionsView.rightAnchor.constraint(equalTo: self.containerView.rightAnchor).isActive = true
    }
    
    override func configure(viewModel: TableViewCell.ViewModelType) {
        let viewModel = viewModel as! FeedTableCellViewModel
        self.viewModel = viewModel
        self.headerView.configure(imageUrl: viewModel.avatarUrl,
                                  title: viewModel.displayName,
                                  subtitle: viewModel.date)
        self.textView.attributedText = viewModel.text
        
        if viewModel.showExpandButton {
            self.expandButton.isHidden = false
            self.textHeightConstraint?.constant = viewModel.textHeight
            self.textHeightConstraint?.isActive = true
            self.photosTopConstraintToExpandButton?.isActive = true
            self.photosTopConstraintToText?.isActive = false

        } else {
            self.expandButton.isHidden = true
            if viewModel.text.string.isEmpty {
                self.textHeightConstraint?.constant = viewModel.textHeight
                self.textHeightConstraint?.isActive = true
            } else {
                self.textHeightConstraint?.isActive = false
            }
            self.photosTopConstraintToExpandButton?.isActive = false
            self.photosTopConstraintToText?.isActive = true
        }
        self.photosHeightConstraint?.constant = viewModel.photosHeight
        self.actionsView.configure(likes: viewModel.likes,
                                   comments: viewModel.comments,
                                   reposts: viewModel.resposts,
                                   views: viewModel.views)
        self.expandButton.isHidden = !viewModel.showExpandButton
        self.photosView.configure(photos: viewModel.photos)
        self.photosView.layoutIfNeeded()
        
    }
    
    @objc
    private func expandedTouch() {
        self.viewModel?.expandedHandler?(self)
    }
    
}

struct FeedTableCellViewModel: TableCellViewModel {
    
    let avatarUrl: URL?
    let displayName: String
    let date: String
    let text: NSAttributedString
    let photos: [URL]
    let likes: String
    let comments: String
    let resposts: String
    let views: String?
    var expanded: Bool
    
    let height: CGFloat
    var textHeight: CGFloat
    let tableWidth: CGFloat
    let photosHeight: CGFloat
    var showExpandButton: Bool
    
    var expandedHandler: ((UITableViewCell) -> Void)?
    
    init(avatarUrl: URL?,
         displayName: String,
         date: String,
         text: NSAttributedString,
         photos: [URL],
         likes: String,
         comments: String,
         resposts: String,
         views: String?,
         expanded: Bool = false,
         tableWidth: CGFloat) {
        self.avatarUrl = avatarUrl
        self.displayName = displayName
        self.date = date
        self.text = text
        self.photos = photos
        self.likes = likes
        self.comments = comments
        self.resposts = resposts
        self.views = views
        self.expanded = expanded
        
        self.tableWidth = tableWidth
        self.textHeight = FeedTableCellViewModel.calculateTextHeight(text: text, tableWidth: tableWidth)
        if photos.count == 0 {
            self.photosHeight = 0
        } else if photos.count == 1 {
            self.photosHeight = FeedPhotosView.contentOnePhotoHeight
        } else {
            self.photosHeight = FeedPhotosView.contentManyPhotosHeight
        }
        
        if text.string.isEmpty {
            self.showExpandButton = false
            self.textHeight = 0
        } else if !expanded, self.textHeight > FeedTableCellViewModel.expandLimit {
            self.textHeight = FeedTableCellViewModel.expandHeight
            self.showExpandButton = true
        } else {
            self.showExpandButton = false
        }
        
        var height = FeedHeaderView.contentHeight
        height += self.textHeight
        height += self.photosHeight
        height += FeedActionsView.contentHeight
        height += 12
        if self.showExpandButton {
            height += 22
        }
        self.height = height
        self.expandedHandler = nil
    }
    
    private static func calculateTextHeight(text: NSAttributedString, tableWidth: CGFloat) -> CGFloat {
        let margins = 2 * (FeedTableViewCell.containerSideOffset + FeedTableViewCell.contentSideOffset)
        let textHeight = text.height(width: tableWidth - margins)
        return textHeight
    }
    
    private static let expandLimit: CGFloat = CustomFont.postText.lineHeight * 8
    private static let expandHeight: CGFloat = CustomFont.postText.lineHeight * 6

    var cellType: TableViewCell.Type { return FeedTableViewCell.self }
}
