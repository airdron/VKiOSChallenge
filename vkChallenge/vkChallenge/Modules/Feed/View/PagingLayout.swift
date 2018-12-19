//
//  PagingLayout.swift
//  vkChallenge
//
//  Created by Andrew Oparin on 10/11/2018.
//  Copyright © 2018 Andrew Oparin. All rights reserved.
//

import Foundation
import UIKit

class PagingLayout: UICollectionViewFlowLayout {
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = self.collectionView else {
            return super.targetContentOffset(forProposedContentOffset: proposedContentOffset)
        }
        var layoutAttributes: Array = layoutAttributesForElements(in: collectionView.bounds)!
        if layoutAttributes.count == 0 {
            return proposedContentOffset
        }
        
        var firstAttribute: UICollectionViewLayoutAttributes = layoutAttributes[0]
        
        for attribute: UICollectionViewLayoutAttributes in layoutAttributes {
            
            if attribute.representedElementCategory != .cell {
                continue
            }
            
            if((velocity.x >= 0.0 && attribute.center.x >= firstAttribute.center.x) ||
                (velocity.x < 0.0 && attribute.center.x <= firstAttribute.center.x)) {
                firstAttribute = attribute;
            }
        }
        
        return CGPoint(x: firstAttribute.center.x - collectionView.bounds.size.width * 0.5, y: proposedContentOffset.y)
    }
}
