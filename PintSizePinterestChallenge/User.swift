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
    
    var boards: [PDKBoard]
    
    
    init(id: String, url: String, username: String, firstName: String, lastName: String, boards: [PDKBoard]) {
        self.id = id
        self.url = url
        self.username = username
        self.firstName = firstName
        self.lastName = lastName
        self.boards = boards
    }
    
    convenience init() {
        self.init(id: "", url: "", username: "", firstName: "", lastName: "", boards: [PDKBoard]())
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
            
            self.getUserBoards()
            
        }) { (error: Error?) in
            print("ERROR: \(error?.localizedDescription)")
        }
    }
    
    func getUserBoards() {
        PDKClient.sharedInstance().getAuthenticatedUserBoards(withFields: Set(arrayLiteral: "id", "name", "url", "description", "image"), success: { (success) in
            
            print("SUCCESS WITH BOARDS!!! :D")
            print("board count: \(success!.boards().count)")
            let responseBoards = success?.boards() as! [PDKBoard]
            for board in responseBoards {
                print(board.name)
                if board.image == nil {
                    print("nil image")
                } else {
                    print(board.image)
                }
            }
            
            self.boards = responseBoards
            
            print("\n******** USER INFO ********\n")
            print("id: \(self.id)")
            print("url: \(self.url)")
            print("username: \(self.username)")
            print("name: \(self.firstName) \(self.lastName)")
            print("board count: \(self.boards.count)")
            print("\n***************************\n")

        }) { (error: Error?) in
            print("ERROR: \(error?.localizedDescription)")
        }
    }
    
    func getBoardPins(boardId: String) {
        // PDKClient.sharedInstance().getBoardPins(boardId, fields: <#T##Set<AnyHashable>!#>, withSuccess: <#T##PDKClientSuccess!##PDKClientSuccess!##(PDKResponseObject?) -> Void#>, andFailure: <#T##PDKClientFailure!##PDKClientFailure!##(Error?) -> Void#>)
    }
}
