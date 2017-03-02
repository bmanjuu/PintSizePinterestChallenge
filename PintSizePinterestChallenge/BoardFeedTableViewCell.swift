//
//  BoardFeedTableViewCell.swift
//  PintSizePinterestChallenge
//
//  Created by Betty Fung on 3/2/17.
//  Copyright © 2017 Betty Fung. All rights reserved.
//

import UIKit

class BoardFeedTableViewCell: UITableViewCell {

    @IBOutlet weak var pinImageView: UIImageView!
    @IBOutlet weak var pinDescriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
