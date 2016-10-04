//
//  CollectionViewLayoutInspector.swift
//  FocusViewLayoutWithNodes
//
//  Created by Sam Stigler on 10/4/16.
//  Copyright © 2016 Sam Stigler. All rights reserved.
//

import AsyncDisplayKit
import Foundation

class CollectionViewLayoutInspector: ASCollectionViewLayoutInspector {
    override func collectionView(collectionView: ASCollectionView, constrainedSizeForNodeAtIndexPath indexPath: NSIndexPath) -> ASSizeRange {
        let width = collectionView.bounds.width
        let maximum = CGSize(width: width, height: 350)
        let minimum = CGSize(width: width, height: 150)
        
        return ASSizeRange(min: minimum, max: maximum)
    }
}