//
//  DMPersonalPortfolioModel.swift
//  Dominant Investors
//
//  Created by Nekit on 19.02.17.
//  Copyright © 2017 Dominant. All rights reserved.
//

import Foundation

class DMPersonalPortfolioModel: NSObject {

    var id          : String?
    var ticker      : String?
    var entry_price : String?
    var userID      : String?
    
    var entry_date  : Date?
    
    init(response : DMResponseObject) {
        super.init()
        self.id = response.id
        self.ticker = response.fields["ticker"] as? String
        self.entry_price = response.fields["entry_price"] as? String
        self.entry_date  = DMDateService.sharedInstance.dominantDateFrom(string: response.fields["crt_at"] as! String)
        self.userID = response.userID
    }
    
    init(stockSearch : StockSearchResult) {
        super.init()
        self.ticker = stockSearch.symbol
    }
    
}
