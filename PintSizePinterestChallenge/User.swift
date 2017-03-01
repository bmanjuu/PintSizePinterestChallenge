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
    var id: String
    var url: String //obtained by calling API
    
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
            
            guard let successResponseObject = successResponseObject else { return }
            
            print("SUCCESS!!!")
            self.id = successResponseObject.user().identifier
            self.url = PinterestAPIClient.obtainUserURL()
            self.username = successResponseObject.user().username
            self.firstName = successResponseObject.user().firstName
            self.lastName = successResponseObject.user().lastName
            // self.boards = successResponseObject.boards() as! [Board]
            
            print("******** USER INFO ********")
            print("id: \(self.id)")
            print("url: \(self.url)")
            print("username: \(self.username)")
            print("name: \(self.firstName) \(self.lastName)")
            print("board count: \(self.boards.count)")
            //print("boards: \(self.boards)")
            /* for board in self.boards {
                print(board)
            } */
            print("***************************")
            
            //should get User and Board information here 
        }) { (error: Error?) in
            print("ERROR: \(error?.localizedDescription)")
        }
    }
}
