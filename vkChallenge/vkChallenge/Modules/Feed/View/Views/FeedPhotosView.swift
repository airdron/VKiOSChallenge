//
//  FeedPhotosView.swift
//  vkChallenge
//
//  Created by Andrew Oparin on 10/11/2018.
//  Copyright © 2018 Andrew Oparin. All rights reserved.
//

import Foundation
import UIKit

class FeedPhotosView: View, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    static let contentOnePhotoHeight: CGFloat = 269
    static let contentManyPhotosHeight: CGFloat = 290
    private let lineSpacing: CGFloat = 4
    private var bottomConstraint: NSLayoutConstraint?
    
    lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.pageIndicatorTintColor = Color.counterIcon.value.withAlphaComponent(0.36)
        pageControl.currentPageIndicatorTintColor = Color.expandText.value
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.isUserInteractionEnabled = false
        return pageControl
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = PagingLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 4
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(cellClass: FeedPhotoCollectionViewCell.self)
        collectionView.backgroundColor = UIColor.white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    override func initialSetup() {
        super.initialSetup()
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.pageControl)
        self.addSubview(collectionView)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        self.collectionView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.collectionView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.collectionView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        
        self.bottomConstraint = self.collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        self.bottomConstraint?.isActive = true
        
        self.pageControl.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
        self.pageControl.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
    
    var photos: [URL] = []
    
    // TODO: performance issue
    
    func configure(photos: [URL]) {
        if photos != self.photos {

            self.photos = photos
    
            if photos.count < 2 {
                collectionView.contentInset.left = 0
                collectionView.contentInset.right = 0
                pageControl.isHidden = true
                self.bottomConstraint?.constant = 0
                
            } else {
                collectionView.contentInset.left = 12
                collectionView.contentInset.right = 12
                pageControl.isHidden = false
                self.bottomConstraint?.constant = -39
            }
            self.collectionView.reloadData()
            self.pageControl.numberOfPages = self.photos.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: FeedPhotoCollectionViewCell.self),
                                                      for: indexPath) as! FeedPhotoCollectionViewCell
        cell.contentImageView.setImage(url: self.photos[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width - collectionView.contentInset.left -
            collectionView.contentInset.right, height: collectionView.bounds.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.updatePageIndex()
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        self.updatePageIndex()
    }
    
    private func updatePageIndex() {
        guard collectionView.bounds.width > CGFloat.leastNonzeroMagnitude else { return }
        let itemWidth = Int(collectionView.bounds.width - collectionView.contentInset.right - collectionView.contentInset.left)
        let index = Int(collectionView.contentOffset.x + 12) / itemWidth
        self.pageControl.currentPage = index
    }
}
