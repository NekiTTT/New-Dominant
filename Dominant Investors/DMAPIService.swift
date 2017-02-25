//
//  DMAPIService.swift
//  Dominant Investors
//
//  Created by Nekit on 18.02.17.
//  Copyright © 2017 Dominant. All rights reserved.
//

import UIKit

class DMAPIService: NSObject {
    
    static let sharedInstance = DMAPIService()
    
    // MARK: Get Data
        
    open func getUserRatings(completion : @escaping ([DMRatingModel]) -> Void) {
        DMQuickBloxService.sharedInstance.getUserRatings(completion: completion)
    }
    
    open func getAnalyticsCompanies(completion : @escaping ([DMCompanyModel]) -> Void) {
        DMQuickBloxService.sharedInstance.getAnalyticsCompanies(completion: completion)
    }
    
    open func getInvestmentSignals(completion : @escaping ([DMInvestmentSignalModel]) -> Void) {
        DMQuickBloxService.sharedInstance.getInvestmentSignals(completion: completion)
    }
    
    open func downloadCompanyImageWith(ID : String, completion : @escaping (UIImage) -> Void) {
    DMQuickBloxService.sharedInstance.downloadCompanyImageWith(ID : ID, completion : completion)
    }
    
    open func downloadCompanyLogoWith(ID : String, completion : @escaping (UIImage) -> Void) {
        DMQuickBloxService.sharedInstance.downloadCompanyLogoWith(ID : ID, completion : completion)
    }
    
    
}
