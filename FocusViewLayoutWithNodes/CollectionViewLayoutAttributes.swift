//
//  CollectionViewLayoutAttributes.swift
//  FocusViewLayoutWithNodes
//
//  Created by Sam Stigler on 10/4/16.
//  Copyright © 2016 Sam Stigler. All rights reserved.
//

import UIKit

class CollectionViewLayoutAttributes: UICollectionViewLayoutAttributes {
    var isLastItem = false
    
    override func copyWithZone(zone: NSZone) -> AnyObject {
        let copy: CollectionViewLayoutAttributes
        switch representedElementCategory {
        case .Cell:
            copy = CollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
        case .DecorationView:
            copy = CollectionViewLayoutAttributes(forDecorationViewOfKind: representedElementKind ?? "", withIndexPath: indexPath)
        case .SupplementaryView:
            copy = CollectionViewLayoutAttributes(forSupplementaryViewOfKind: representedElementKind ?? "", withIndexPath: indexPath)
        }
        
        copy.alpha = alpha
        copy.bounds = bounds
        copy.center = center
        copy.frame = frame
        copy.hidden = hidden
        copy.isLastItem = isLastItem
        copy.size = size
        copy.transform = transform
        copy.transform3D = transform3D
        copy.zIndex = zIndex
        
        return copy
    }
}
