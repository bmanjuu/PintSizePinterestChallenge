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

let store = PinterestUserDataStore.sharedInstance

class User {
    
    var boardsAndPins = [PDKBoard: [PDKPin]]()
    var currentUser: PDKUser = PDKUser()
    
}

//MARK: - Authentication
extension User {
    func authenticateUser(in VC: UIViewController) {
        print("called authenticate user function")
        
        let permissions = [PDKClientReadPublicPermissions, PDKClientWritePublicPermissions, PDKClientReadRelationshipsPermissions, PDKClientWriteRelationshipsPermissions]
        
        PDKClient.sharedInstance().authenticate(withPermissions: permissions, from: VC, withSuccess: { (successResponseObject) -> Void in
            
            guard let successResponseObject = successResponseObject else { return }
            
            print("SUCCESS!!!")
            store.user.currentUser = successResponseObject.user()
            
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
            let responseBoards = success?.boards() as! [PDKBoard]
            for board in responseBoards {
                if board.largestImage().url == nil {
                    print("ERROR: no image for board available")
                    return
                }
                
                if store.user.boardsAndPins.keys.contains(board) {
                    return
                } else {
                    self.getBoardPins(for: board, boardId: board.identifier)
                }
                
            }
            
            store.finishedRetrievingData = true
            
        }) { (error: Error?) in
            print("BOARD ERROR: \(error?.localizedDescription)")
        }
    }
}


//MARK: - Get user's pins for a specified board
extension User {
    
    func getBoardPins(for board: PDKBoard, boardId: String) {
        
        PDKClient.sharedInstance().getBoardPins(boardId, fields: Set(arrayLiteral: "id", "note", "image", "url"), withSuccess: { (responseSuccess) in
            
            print("OBTAINED PINS")
            print(responseSuccess!.pins().count)
            
            store.user.boardsAndPins[board] = (responseSuccess!.pins() as! [PDKPin])
            
            print("\n******** USER INFO ********\n")
            print("id: \(store.user.currentUser.identifier)")
            print("username: \(store.user.currentUser.username)")
            print("name: \(store.user.currentUser.firstName) \(store.user.currentUser.lastName)")
            print("board count: \(store.user.boardsAndPins.keys.count)")
            print("board pins: \n")
            for (board, pins) in store.user.boardsAndPins {
                print("board: \(board.name!), pin count: \(pins.count)")
            }
            print("\n***************************\n")
            
        }) { (responseError) in
            print("PIN ERROR: \(responseError!.localizedDescription)")
        }
        
    }
}

extension PDKPin {
    
    var displayPinImage: UIImage {
        return ImageHelper.obtainImagefrom(link: self.largestImage().url)
    }
    
    func heightForComment(font: UIFont, width: CGFloat, pin: PDKPin) -> CGFloat {
        let rect = NSString(string: pin.descriptionText).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        return ceil(rect.height)
    }

}
