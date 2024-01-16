//
//  StretchyHeaderLayout.swift
//  FaceBook_Like_Animation
//
//  Created by Nimol on 15/1/24.
//

import UIKit

class StretchyHeaderLayout: UICollectionViewFlowLayout {
    
    // we want to modify the attribute of ouer header somehow
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let layoutAttribute = super.layoutAttributesForElements(in: rect)
        layoutAttribute?.forEach({ attribute in
            if attribute.representedElementKind == UICollectionView.elementKindSectionHeader && attribute.indexPath.section == 0 {
                guard let collectionView = collectionView else {return }
                let width = collectionView.frame.width
                let contentOffsetY = collectionView.contentOffset.y
            
                if contentOffsetY > 0 {
                    return
                }
                let height = attribute.frame.height - contentOffsetY
                // header
                attribute.frame = CGRect(x: 0, y: contentOffsetY, width: width, height: height)
            }
            
        })
        return layoutAttribute
    }
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true 
    }
 }
