//
//  Board.swift
//  PintSizePinterestChallenge
//
//  Created by Betty Fung on 3/1/17.
//  Copyright © 2017 Betty Fung. All rights reserved.
//

import Foundation
import PinterestSDK

class Board /*: PDKBoard*/ {
    let id: String
    let url: String
    let creator: User
    
    var name: String
    var description: String
    var pins: [Pin]
    
    
    init(id: String, url: String, creator: User, name: String, description: String, pins: [Pin]) {
        self.id = id
        self.url = url
        self.creator = creator
        self.name = name
        self.description = description
        self.pins = pins
    }
}
