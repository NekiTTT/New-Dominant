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
        
        self.ticker                 = fields["companySymbol"] as! String
        self.name                   = fields["companyName"] as! String
        self.IPODate                = fields["IPODate"] as! String
        self.marketCapitalization   = fields["marketCapitalization"] as! String
        self.companyDescription     = fields["description"]  as! String
        self.annualSales            = fields["annualSales"]  as! String
        self.averageSales           = fields["averageSales"] as! String

        self.potentialProfitability = fields["potantialProfitability"] as! String
    }
}
