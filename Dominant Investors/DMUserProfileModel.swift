//
//  DMUserProfileModel.swift
//  Dominant Investors
//
//  Created by Nekit on 19.02.17.
//  Copyright © 2017 Dominant. All rights reserved.
//

import Foundation
import Quickblox

class DMUserProfileModel: NSObject, NSCoding {
    
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
    
    // MARK : NSCoding
    
    required init(coder aDecoder: NSCoder) {
        self.userID           = aDecoder.decodeObject(forKey: "userID") as! String
        self.userName         = aDecoder.decodeObject(forKey: "userName") as! String
        self.userRating       = aDecoder.decodeObject(forKey: "userRating") as! UInt
    }
    
     public func encode(with aCoder: NSCoder) {
        aCoder.encode(self.userID, forKey: "userID")
        aCoder.encode(self.userName, forKey: "userName")
        aCoder.encode(self.userRating, forKey: "userRating")
    }
}
