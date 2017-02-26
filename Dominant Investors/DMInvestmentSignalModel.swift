//
//  DMInvestmentSignalModel.swift
//  Dominant Investors
//
//  Created by Nekit on 19.02.17.
//  Copyright © 2017 Dominant. All rights reserved.
//

import Foundation

class DMInvestmentSignalModel: NSObject {

    var id          : String!
    var ticker      : String!
    var entry_price : String?
    var potential   : String?
    var stop_loss   : String?
    
    init(response : DMResponseObject) {
        super.init()
        self.id = response.id
        let fields = response.fields
        
        self.ticker      = fields["ticker"] as? String
        self.entry_price = fields["entryPrice"] as? String
        self.potential   = fields["potential"] as? String
        self.stop_loss   = fields["stopLoss"] as? String
    }
    
    
}
