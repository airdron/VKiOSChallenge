//
//  CollectionView.swift
//  vkChallenge
//
//  Created by Andrew Oparin on 10/11/2018.
//  Copyright © 2018 Andrew Oparin. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionView {
    
    func register(cellClass: UICollectionViewCell.Type) {
        self.register(cellClass,
                      forCellWithReuseIdentifier: String(describing: cellClass))
    }
    
    func registerHeader(headerClass: UICollectionReusableView.Type) {
        self.register(headerClass,
                      forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                      withReuseIdentifier: String(describing: headerClass))
    }
    
    func registerFooter(footerClass: UICollectionReusableView.Type) {
        self.register(footerClass,
                      forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                      withReuseIdentifier: String(describing: footerClass))
    }
}
