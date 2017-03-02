//
//  PinterestUserDataStore.swift
//  PintSizePinterestChallenge
//
//  Created by Betty Fung on 3/1/17.
//  Copyright © 2017 Betty Fung. All rights reserved.
//

import Foundation
import PinterestSDK
import CoreData

final class PinterestUserDataStore {
    static let sharedInstance = PinterestUserDataStore()
    private init() {}
    
    var user: User = User()
    //var user: PDKUser = PDKUser()
    //var userBoardsAndPins : [PDKBoard: [PDKPin]] = [PDKBoard: [PDKPin]] ()
}
