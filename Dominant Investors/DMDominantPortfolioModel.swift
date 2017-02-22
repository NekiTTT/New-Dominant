//
//  DMDominantPortfolioModel.swift
//  Dominant Investors
//
//  Created by Nekit on 19.02.17.
//  Copyright © 2017 Dominant. All rights reserved.
//

import Foundation
import Quickblox

class DMDominantPortfolioModel: NSObject {

    var id : String!
    var ticker : String!
    var exchange : String!
    
    init(response : DMResponseObject) {
        super.init()
    
        self.id       = response.id
        self.ticker   = response.fields["ticker"] as! String
        self.exchange = response.fields["exchange"] as! String
    }
    
    
}
