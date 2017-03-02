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
    
    var userBoardAndPins : [PDKBoard: [PDKPin]] = [PDKBoard: [PDKPin]] ()
}
