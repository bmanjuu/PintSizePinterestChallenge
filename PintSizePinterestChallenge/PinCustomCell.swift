//
//  PinCustomCell.swift
//  PintSizePinterestChallenge
//
//  Created by Betty Fung on 3/3/17.
//  Copyright © 2017 Betty Fung. All rights reserved.
//

import UIKit

class PinCustomCell: UICollectionViewCell {
    
    @IBOutlet weak var pinImageView: UIImageView!
    @IBOutlet weak var pinImageHeightLayoutConstraint: NSLayoutConstraint!
    @IBOutlet weak var descriptionTitle: UILabel!
    @IBOutlet weak var descriptionText: UILabel!
    
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        if let attributes = layoutAttributes as? PinterestCustomLayoutAttributes {
            pinImageHeightLayoutConstraint.constant = attributes.photoHeight
        }
    }
 
     /*
     when this bit of code is active for setting the height of the photo, the images don't show up b/c it conflicts with the height of the photo that we set through autolayout by making the height of the imageview the same as that of the cell. so, we are automatically doing what this function wants to do through autolayout without actually having to call this function.
     however, when the height of the cell/the bottom constraint is not pinned to the bottom of the collection view cell, we still encounter the same issues, so I will be leaving the height of the image equal to the height of the cell for now.
     
 */
}
