//
//  CellNode.swift
//  FocusViewLayoutWithNodes
//
//  Created by Sam Stigler on 10/4/16.
//  Copyright © 2016 Sam Stigler. All rights reserved.
//

import AsyncDisplayKit
import UIKit

class CellNode: ASCellNode {
    
    var text: String {
        get {
            return label.attributedText?.string ?? ""
        }
        
        set {
            let paragraphStyle = NSParagraphStyle.defaultParagraphStyle().mutableCopy() as! NSMutableParagraphStyle
            paragraphStyle.lineBreakMode = .ByTruncatingTail
            
            let attributes = [NSFontAttributeName : UIFont.systemFontOfSize(20),
                              NSForegroundColorAttributeName : UIColor.whiteColor(),
                              NSParagraphStyleAttributeName : paragraphStyle]
            
            label.attributedText = NSAttributedString(string: newValue, attributes: attributes)
        }
    }
    
    private let label = ASTextNode()
    let backgroundImageNode = ASImageNode()
    
    private let LabelInsets = UIEdgeInsets(top: 0, left: 20, bottom: 20, right: 20)
    
    override init() {
        super.init()
        
        addSubnode(backgroundImageNode)
        addSubnode(label)
    }
    
    // MARK: - Layout
    
    override func layout() {
        super.layout()
        
        backgroundImageNode.frame = frameForBackgroundImage()
    }
    
    override func applyLayoutAttributes(layoutAttributes: UICollectionViewLayoutAttributes) {
        super.applyLayoutAttributes(layoutAttributes)
        
        if layoutAttributes.size != bounds.size {
            setNeedsLayout()
        }
        
        guard let customLayoutAttributes = layoutAttributes as? CollectionViewLayoutAttributes else {
            return
        }
        
        let screenWidth = UIScreen.mainScreen().bounds.width
        let focusedCellSize = CGSize(width: screenWidth, height: 350)
        
        let cellSizeForLayout = customLayoutAttributes.isLastItem ? focusedCellSize : layoutAttributes.size
        
        label.frame = frameForLabel(givenCellSize: cellSizeForLayout)
    }
    
    override func calculateSizeThatFits(constrainedSize: CGSize) -> CGSize {
        return CGSize(width: constrainedSize.width, height: constrainedSize.height)
    }
    
    private func frameForBackgroundImage() -> CGRect {
        let screenWidth = UIScreen.mainScreen().bounds.width
        let sizeForBackgroundImage = CGSize(width: screenWidth, height: 350)
        
        return CGRect(origin: CGPointZero, size: sizeForBackgroundImage)
    }
    
    private func frameForLabel(givenCellSize cellSize: CGSize) -> CGRect {
        let maxSize = CGSize(width: cellSize.width - LabelInsets.left - LabelInsets.right,
                             height: cellSize.height - LabelInsets.top - LabelInsets.bottom)
        let labelSize = label.attributedText?.sizeConstrainedToSize(maxSize) ?? CGSizeZero
        let position = CGPoint(x: LabelInsets.left, y: cellSize.height - LabelInsets.bottom - labelSize.height)
        
        return CGRect(origin: position, size: labelSize)
    }
}

private extension NSAttributedString {
    func sizeConstrainedToSize(maxSize: CGSize) -> CGSize {
        let boundingRect = boundingRectWithSize(maxSize, options: .TruncatesLastVisibleLine, context: nil)
        
        return boundingRect.size
    }
}
