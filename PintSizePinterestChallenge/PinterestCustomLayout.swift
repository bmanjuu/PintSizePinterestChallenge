//
//  PinFeedCustomLayout.swift
//  PintSizePinterestChallenge
//
//  Created by Betty Fung on 3/3/17.
//  Copyright © 2017 Betty Fung. All rights reserved.
//

import UIKit

/* the following is based off of Ray Wenderlich's tutorial (seen here: https://www.raywenderlich.com/107439/uicollectionview-custom-layout-tutorial-pinterest) and converted into Swift 3 syntax */


protocol PinterestCustomLayoutDelegate {
    func collectionView(collectionView:UICollectionView, heightForPhotoAtIndexPath indexPath:NSIndexPath, withWidth:CGFloat) -> CGFloat
    
    func collectionView(collectionView: UICollectionView,
                        heightForAnnotationAtIndexPath indexPath: NSIndexPath, withWidth width: CGFloat) -> CGFloat
}



class PinterestCustomLayoutAttributes: UICollectionViewLayoutAttributes {

    var photoHeight: CGFloat = 0.0
    
    override func copy(with zone: NSZone?) -> Any {
        let copy = super.copy(with: zone) as! PinterestCustomLayoutAttributes
        copy.photoHeight = photoHeight
        return copy
    }
    
    
    override func isEqual(_ object: Any?) -> Bool {
        if let attributes = object as? PinterestCustomLayoutAttributes {
            if(attributes.photoHeight == photoHeight) {
                return super.isEqual(object)
            }
        }
        return false
    }
    
}



class PinterestCustomLayout: UICollectionViewLayout {
    
    var delegate: PinterestCustomLayoutDelegate!
    
    var numberOfColumns = 2
    var cellPadding: CGFloat = 6.0

    private var cache = [PinterestCustomLayoutAttributes]()
    
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
                
                let attributes = PinterestCustomLayoutAttributes(forCellWith: indexPath as IndexPath)
                attributes.frame = insetFrame
                cache.append(attributes)
                
                contentHeight = max(contentHeight, frame.maxY)
                yOffset[column] = yOffset[column] + height
                
                column = ((column >= (numberOfColumns - 1)) ? 0 : 1+column)
            }
        }
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override class var layoutAttributesClass: AnyClass {
        return PinterestCustomLayoutAttributes.self
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                layoutAttributes.append(attributes)
            }
        }
        return layoutAttributes
    }

}
