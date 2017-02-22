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
    var entry_price : String!
    var potential   : String!
    var stop_loss   : String!
    
    init(response : DMResponseObject) {
        super.init()
        
    }
    
    
}
