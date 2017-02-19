//
//  DMUserProfileModel.swift
//  Dominant Investors
//
//  Created by Nekit on 19.02.17.
//  Copyright © 2017 Dominant. All rights reserved.
//

import Foundation
import Quickblox

class DMUserProfileModel: NSObject {

    var userID            : String!
    var userName          : String!
    var userProfileImage  : String!
    
    var userRating        : UInt!
    
    init(QBUser : QBUUser) {
        super.init()
        self.userID           = String(QBUser.id)
        self.userName         = QBUser.login
        self.userProfileImage = QBUser.customData
        self.userRating       = 0
    }
}
