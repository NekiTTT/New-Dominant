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
    var IPODate                     : String!
    
    var marketCapitalization        : String!
    var averageSales                : String!
    var annualSales                 : String!
    var companyDescription          : String!
    var forecast                    : String!
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
        
        if let value = fields["IPODate"] as? String {
            self.IPODate = value
        } else {
            self.IPODate = ""
        }
        
        if let value = fields["marketCapitalization"] as? String {
            self.marketCapitalization = value
        } else {
            self.marketCapitalization = ""
        }
        
        if let value = fields["description"] as? String {
            self.companyDescription = value
        } else {
            self.companyDescription = ""
        }
        
        if let value = fields["annualSales"] as? String {
            self.annualSales = value
        } else {
            self.annualSales = ""
        }
        
        if let value = fields["averageSales"] as? String {
            self.averageSales = value
        } else {
            self.averageSales = ""
        }
        
        if let value = fields["potentialProfitability"] as? String {
            self.potentialProfitability = value
        } else {
            self.potentialProfitability = ""
        }
        
    }
}
