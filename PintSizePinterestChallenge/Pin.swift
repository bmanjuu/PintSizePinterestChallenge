//
//  Pin.swift
//  PintSizePinterestChallenge
//
//  Created by Betty Fung on 3/1/17.
//  Copyright © 2017 Betty Fung. All rights reserved.
//

import Foundation
import UIKit

class Pin {
    let id: String
    let url: String //The URL of the Pin on Pinterest. different from link, which is the URL of the webpage where the Pin was created.
    let creator: User
    let image: (url: String, size: CGRect)
    var note: String //this is the pin description
    
    var board: Board
    
    
    init(id: String, url: String, creator: User, image: (url: String, size: CGRect), note: String, board: Board) {
        self.id = id
        self.url = url
        self.creator = creator
        self.image = image
        self.note = note
        self.board = board
    }
}
