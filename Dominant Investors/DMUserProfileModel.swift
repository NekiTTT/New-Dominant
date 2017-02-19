//
//  DMUserProfileModel.swift
//  Dominant Investors
//
//  Created by Nekit on 19.02.17.
//  Copyright © 2017 Dominant. All rights reserved.
//

import Foundation

class DMUserProfileModel: NSObject {

    var userID            : String!
    var userName          : String!
    var userProfileImage  : String!
    
    var userRating        : UInt!
    
    init(response : Any) {
        super.init()
        
    }
}
