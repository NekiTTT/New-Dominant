//
//  DMCompanyModel.swift
//  Dominant Investors
//
//  Created by Nekit on 19.02.17.
//  Copyright © 2017 Dominant. All rights reserved.
//

import Foundation
import Quickblox

class DMCompanyModel: NSObject {

    
    var id                          : String!
    var ticker                      : String!
    var name                        : String!
    var companylogo                 : UIImage!
    var companyPictureURL           : UIImage!
    
    var buyPoint                    : String!
    var stopLoss                    : String!
    var targetPrice                 : String!
    var investmentHorizon           : String!
    var companyDescription          : String!

    var potentialProfitability      : String!
    
    init(response : DMResponseObject) {
        super.init()
        self.id = response.id
        let fields = response.fields
        
        if let ticker = fields["companySymbol"] as? String {
            self.ticker = ticker
        } else {
            self.ticker = ""
        }
        
        if let value = fields["companyName"] as? String {
            self.name = value
        } else {
            self.name = ""
        }
        
        if let value = fields["buyPoint"] as? String {
            self.buyPoint = value
        } else {
            self.buyPoint = ""
        }
        
        if let value = fields["stopLoss"] as? String {
            self.stopLoss = value
        } else {
            self.stopLoss = ""
        }
        
        if let value = fields["companyDescription"] as? String {
            self.companyDescription = value
        } else {
            self.companyDescription = ""
        }
        
        if let value = fields["targetPrice"] as? String {
            self.targetPrice = value
        } else {
            self.targetPrice = ""
        }
        
        if let value = fields["investmentHorizon"] as? String {
            self.investmentHorizon = value
        } else {
            self.investmentHorizon = ""
        }
        
        if let value = fields["potentialProfitability"] as? String {
            self.potentialProfitability = value
        } else {
            self.potentialProfitability = ""
        }
        
    }
}
