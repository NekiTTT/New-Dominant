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

    // MARK : Get Data
    
    open func getPersonalPortfolio(completion : ([DMPersonalPortfolioModel]) -> Void) {
        
    }
    
    open func getDominantPortfolio(completion : ([DMDominantPortfolioModel]) -> Void) {
        
    }
    
    open func getUserRatings(completion : ([DMRatingModel]) -> Void) {
        
    }

    open func getAnalyticsCompanies(completion : ([DMCompanyModel]) -> Void) {
        
    }
    
    open func getInvestmentSignals(completion : ([DMInvestmentSignalModel]) -> Void) {
        
    }
    
    // MARK : Set Data
    
    open func addNew(personalStock : DMPersonalPortfolioModel, completion : ([DMPersonalPortfolioModel]) -> Void) {
        
    }
    
    open func clearPortfolio(completion : ([DMPersonalPortfolioModel]) -> Void) {
        
    }
    
    // MARK : Private
    
    private func updateUserRating() {
        
    }

    
}
