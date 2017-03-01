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
    
    
    init(id: String, url: String, username: String, firstName: String, lastName: String, boards: [Board]) {
        self.id = id
        self.url = url
        self.username = username
        self.firstName = firstName
        self.lastName = lastName
        self.boards = boards
    }
    
    init() {
        self.init(id: "", url: "", username: "", firstName: "", lastName: "", boards: [Board]())
    }
}

extension User {
    func authenticateUser() {
        
    }
}
