//
//  User.swift
//  PintSizePinterestChallenge
//
//  Created by Betty Fung on 3/1/17.
//  Copyright © 2017 Betty Fung. All rights reserved.
//

import Foundation
import UIKit
import PinterestSDK

class User {
    var id: String
    
    var username: String
    var firstName: String
    var lastName: String
    
    var boards: [PDKBoard]
    var boardsAndPins: [PDKBoard: [PDKPin]]
    
    
    init(id: String, username: String, firstName: String, lastName: String, boards: [PDKBoard], boardsAndPins: [PDKBoard: [PDKPin]]) {
        self.id = id
        self.username = username
        self.firstName = firstName
        self.lastName = lastName
        self.boards = boards
        self.boardsAndPins = boardsAndPins
    }
    
    convenience init() {
        self.init(id: "", username: "", firstName: "", lastName: "", boards: [PDKBoard](), boardsAndPins: [:])
    }
}

//MARK: - Authentication
extension User {
    func authenticateUser(in VC: UIViewController) {
        print("called authenticate user function")
        
        let permissions = [PDKClientReadPublicPermissions, PDKClientWritePublicPermissions, PDKClientReadRelationshipsPermissions, PDKClientWriteRelationshipsPermissions]
        
        PDKClient.sharedInstance().authenticate(withPermissions: permissions, from: VC, withSuccess: { (successResponseObject) -> Void in
            
            guard let successResponseObject = successResponseObject else { return }
            
            print("SUCCESS!!!")
            self.id = successResponseObject.user().identifier
            self.username = successResponseObject.user().username
            self.firstName = successResponseObject.user().firstName
            self.lastName = successResponseObject.user().lastName
            
            self.getUserBoards()
            
        }) { (error: Error?) in
            print("ERROR: \(error?.localizedDescription)")
        }
    }
}

//MARK: - Obtain User's Board Information
extension User {

    func getUserBoards() {
        
        PDKClient.sharedInstance().getAuthenticatedUserBoards(withFields: Set(arrayLiteral: "id", "name", "url", "description", "image"), success: { (success) in
            
            print("SUCCESS WITH BOARDS!!! :D")
            print("board count: \(success!.boards().count)")
            let responseBoards = success?.boards() as! [PDKBoard]
            for board in responseBoards {
                if board.largestImage().url == nil {
                    print("ERROR: no image for board available")
                    return
                }
                
                //call method to obtain pins here
                
                self.boardsAndPins[board] = [PDKPin]()
                //start populating dictionary with board keys
            }
            
            self.boards = responseBoards
            
            print("\n******** USER INFO ********\n")
            print("id: \(self.id)")
            print("username: \(self.username)")
            print("name: \(self.firstName) \(self.lastName)")
            print("board count: \(self.boards.count)")
            print("\n***************************\n")

        }) { (error: Error?) in
            print("BOARD ERROR: \(error?.localizedDescription)")
        }
    }
    
    func getBoardPins(boardId: String) -> [PDKPin] {
        
        var pinsForBoard = [PDKPin]()
        
        PDKClient.sharedInstance().getBoardPins(boardId, fields: Set(arrayLiteral: "id", "name", "url", "description", "image"), withSuccess: { (responseSuccess) in
            
            print("OBTAINED PINS")
            print(responseSuccess)
            
        }) { (responseError) in
            print("PIN ERROR: \(responseError!.localizedDescription)")
        }
        
        return pinsForBoard
    }
}
