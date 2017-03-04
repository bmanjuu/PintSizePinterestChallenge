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
 }
