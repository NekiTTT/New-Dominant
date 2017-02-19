//
//  DMRatingModel.swift
//  Dominant Investors
//
//  Created by Nekit on 19.02.17.
//  Copyright © 2017 Dominant. All rights reserved.
//

import Foundation

class DMRatingModel: NSObject {

    var id               : String!
    var userID           : Int!
    var userName         : String!
    var invesmentStocks  = [DMPersonalPortfolioModel]()
    var totalValue       = 0.0
    
    init(response : Any) {
        super.init()
        
    }
    
}
