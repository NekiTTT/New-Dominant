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
        
        if let respID = response.id {
            self.id       = respID
        }
        
        if let respValue = response.fields["ticker"] as? String {
            self.ticker       = respValue
        }
        
        if let respValue = response.fields["entry_price"] as? String {
            self.entry_price       = respValue
        }
        
        if let respValue = response.fields["crt_at"] as? String {
            self.entry_date       = DMDateService.sharedInstance.dominantDateFrom(string: respValue)
        }
        
        if let respValue = response.userID {
            self.userID       = respValue
        }

    }
    
    init(stockSearch : StockSearchResult) {
        super.init()
        self.ticker = stockSearch.symbol
    }
    
}
