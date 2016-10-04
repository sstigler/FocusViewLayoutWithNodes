//
//  ViewController.swift
//  FocusViewLayoutWithNodes
//
//  Created by Sam Stigler on 10/4/16.
//  Copyright © 2016 Sam Stigler. All rights reserved.
//

import AsyncDisplayKit
import UIKit

class ViewController: ASViewController {
    
    private let collectionNode: ASCollectionNode
    
    var imageNames = [String]()
    
    init() {
        let layout = SFFocusViewLayout()
        layout.focusedHeight = 350
        layout.standardHeight = 150
        
        collectionNode = ASCollectionNode(collectionViewLayout: layout)
        collectionNode.view.layoutInspector = CollectionViewLayoutInspector(collectionView: collectionNode.view)
        
        super.init(node: collectionNode)
        
        initializeModel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initializeModel() {
        for photoNumber in 1 ... 8 {
            let name = "photo\(photoNumber)"
            imageNames.append(name)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionNode()
    }
    
    private func configureCollectionNode() {
        collectionNode.view.asyncDataSource = self
        collectionNode.backgroundColor = UIColor.lightGrayColor()
        collectionNode.reloadData()
    }
}

extension ViewController: ASCollectionDataSource {
    func collectionView(collectionView: ASCollectionView, nodeBlockForItemAtIndexPath indexPath: NSIndexPath) -> ASCellNodeBlock {
        return { [weak self] in
            // TODO: Change this to create an actual ROHMemberCell.
            let imageName = self?.imageNames[indexPath.item] ?? "unknown image"
            let node = CellNode()
            node.backgroundImageNode.image = UIImage(named: imageName)
            node.text = imageName

            return node
        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageNames.count
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
}
