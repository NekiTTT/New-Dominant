//
//  DMRatingModel.swift
//  Dominant Investors
//
//  Created by Nekit on 19.02.17.
//  Copyright © 2017 Dominant. All rights reserved.
//

import Foundation
import Quickblox

class DMRatingModel: NSObject {

    var id               : String!
    var userID           : String!
    var userName         : String!
    var invesmentStocks  = [DMPersonalPortfolioModel]()
    var totalValue       = 0.0
    var position : Int   = 1
    
    init(response : DMResponseObject) {
        super.init()
        self.id = response.id
        self.userName   = response.fields["userName"] as! String
        self.totalValue = response.fields["portfolioTotalValue"] as! Double
        self.userID     = response.fields["userID"] as! String
        
    }
    
}
