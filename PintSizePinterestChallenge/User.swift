//
//  User.swift
//  PintSizePinterestChallenge
//
//  Created by Betty Fung on 3/1/17.
//  Copyright © 2017 Betty Fung. All rights reserved.
//

import Foundation

class User {
    let id: String
    let url: String //obtained by calling API 
    
    var username: String
    var firstName: String
    var lastName: String
    
    var boards: [Board]
}
