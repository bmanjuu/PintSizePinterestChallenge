//
//  User.swift
//  PintSizePinterestChallenge
//
//  Created by Betty Fung on 3/1/17.
//  Copyright © 2017 Betty Fung. All rights reserved.
//

import Foundation
import PinterestSDK

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
    
    convenience init() {
        self.init(id: "", url: "", username: "", firstName: "", lastName: "", boards: [Board]())
    }
}

extension User {
    func authenticateUser(in VC: UIViewController) {
        print("called authenticate user function")
        
        let permissions = [PDKClientReadPublicPermissions, PDKClientWritePublicPermissions, PDKClientReadRelationshipsPermissions, PDKClientWriteRelationshipsPermissions]
        
        
        
        PDKClient.sharedInstance().authenticate(withPermissions: permissions, from: VC, withSuccess: { (successResponseObject) -> Void in
            
            VC.performSegue(withIdentifier: "showBoards", sender: nil)
            //should redirect back to the app here
        }) { (error: Error?) in
            print("ERROR: \(error?.localizedDescription)")
        }
    }
}
