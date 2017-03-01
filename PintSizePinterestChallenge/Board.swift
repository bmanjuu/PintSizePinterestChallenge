//
//  Board.swift
//  PintSizePinterestChallenge
//
//  Created by Betty Fung on 3/1/17.
//  Copyright © 2017 Betty Fung. All rights reserved.
//

import Foundation

class Board {
    let id: String
    let url: String
    let creator: User
    
    var name: String
    var description: String
    var pins: [Pin]
}
