//
//  CollectionConfigurator.swift
//  vkChallenge
//
//  Created by Andrew Oparin on 11/11/2018.
//  Copyright © 2018 Andrew Oparin. All rights reserved.
//

import Foundation
import UIKit

class CollectionConfigurator: NSObject,
                              UICollectionViewDelegate,
                              UICollectionViewDataSource,
                              UICollectionViewDelegateFlowLayout {
    
    var onPage: ((_ numPage: Int) -> ())?
    
    var photos: [URL] = [] {
        didSet {
            if oldValue != self.photos {
                self.collectionView?.reloadData()
            }
        }
    }
    
    weak var collectionView: UICollectionView?
    
    func configure(collectionView: UICollectionView, photos: [URL]) {
        self.collectionView = collectionView
        self.photos = photos
        self.collectionView?.delegate = self
        self.collectionView?.dataSource = self
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
        guard let collectionView = self.collectionView else {
            return
        }
        guard collectionView.bounds.width > CGFloat.leastNonzeroMagnitude else { return }
        let itemWidth = Int(collectionView.bounds.width - collectionView.contentInset.right - collectionView.contentInset.left)
        let index = Int(collectionView.contentOffset.x + 12) / itemWidth
        self.onPage?(index)
    }
}
