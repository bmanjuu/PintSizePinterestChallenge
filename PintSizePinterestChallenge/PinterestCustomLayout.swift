//
//  PinFeedCustomLayout.swift
//  PintSizePinterestChallenge
//
//  Created by Betty Fung on 3/3/17.
//  Copyright © 2017 Betty Fung. All rights reserved.
//

import UIKit

/* the following is based off of Ray Wenderlich's tutorial (seen here: https://www.raywenderlich.com/107439/uicollectionview-custom-layout-tutorial-pinterest) and converted into Swift 3 syntax */

class PinterestCustomLayout: UICollectionViewLayout {
    
    var delegate: PinterestCustomLayoutDelegate!
    
    var numberOfColumns = 2
    var cellPadding: CGFloat = 6.0

    private var cache = [UICollectionViewLayoutAttributes]()
    
    private var contentHeight: CGFloat  = 0.0
    private var contentWidth: CGFloat {
        let insets = collectionView!.contentInset
        return collectionView!.bounds.width - (insets.left + insets.right)
    }
    
    override func prepare() {

        if cache.isEmpty {
            let columnWidth = contentWidth / CGFloat(numberOfColumns)
            var xOffset = [CGFloat]()
            for column in 0 ..< numberOfColumns {
                xOffset.append(CGFloat(column) * columnWidth )
            }
            var column = 0
            var yOffset = [CGFloat](repeating: 0, count: numberOfColumns)
            
            for item in 0 ..< collectionView!.numberOfItems(inSection: 0) {
                
                let indexPath = NSIndexPath(item: item, section: 0)
                
                let width = columnWidth - cellPadding * 2
                let photoHeight = delegate.collectionView(collectionView: collectionView!,
                                                          heightForPhotoAtIndexPath: indexPath,
                                                          withWidth:width)
                let annotationHeight = delegate.collectionView(collectionView: collectionView!,
                                                               heightForAnnotationAtIndexPath: indexPath,
                                                               withWidth: width)
                let height = cellPadding +  photoHeight + annotationHeight + cellPadding
                let frame = CGRect(x: xOffset[column], y: yOffset[column], width: columnWidth, height: height)
                let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
                
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath as IndexPath)
                attributes.frame = insetFrame
                cache.append(attributes)
                
                contentHeight = max(contentHeight, frame.maxY)
                yOffset[column] = yOffset[column] + height
                
                column = column >= (numberOfColumns - 1) ? 0 : +column
            }
        }
    }

}

protocol PinterestCustomLayoutDelegate {
    func collectionView(collectionView:UICollectionView, heightForPhotoAtIndexPath indexPath:NSIndexPath, withWidth:CGFloat) -> CGFloat
    
    func collectionView(collectionView: UICollectionView,
                        heightForAnnotationAtIndexPath indexPath: NSIndexPath, withWidth width: CGFloat) -> CGFloat
}
