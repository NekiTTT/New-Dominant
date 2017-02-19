//
//  DMPersonalPortfolioModel.swift
//  Dominant Investors
//
//  Created by Nekit on 19.02.17.
//  Copyright © 2017 Dominant. All rights reserved.
//

import Foundation

class DMPersonalPortfolioModel: NSObject {

    var id          : String!
    var ticker      : String!
    var entry_price : String!
    var userID      : Int!
    
    var entry_date  : Date!
    
    init(response : Any) {
        super.init()
        
    }
    
}
