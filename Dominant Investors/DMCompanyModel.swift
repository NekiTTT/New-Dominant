//
//  DMCompanyModel.swift
//  Dominant Investors
//
//  Created by Nekit on 19.02.17.
//  Copyright © 2017 Dominant. All rights reserved.
//

import Foundation

class DMCompanyModel: NSObject {

    
    var id                          : String!
    var ticker                      : String!
    var name                        : String!
    var companyPictureFileLocalPath : String!
    var companyPictureURL           : String!
    var IPODate                     : String!
    
    var marketCapitalization        : String!
    var averageSales                : String!
    var annualSales                 : String!
    var companyDescription          : String!
    var forecast                    : String!
    var potentialProfitability      : String!
    
    init(response : Any) {
        super.init()
        
    }
}
