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
    let url: String
    let creater: User
    let image: (url: String, size: CGRect)
    
    var board: Board
    var note: String
}
