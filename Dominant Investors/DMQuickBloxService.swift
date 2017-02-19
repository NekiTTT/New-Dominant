//
//  DMQuickBloxService.swift
//  Dominant Investors
//
//  Created by Nekit on 18.02.17.
//  Copyright © 2017 Dominant. All rights reserved.
//

import UIKit

class DMQuickBloxService: NSObject {

    static let sharedInstance = DMQuickBloxService()
    
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
    
    open func loginWith(login : String, password : String, competion : (Bool) -> Void) {
        
    }
    
    open func signUpWith(login : String, email : String, password : String, confirm : String , completion : (Bool) -> Void) {
        
    }
    
    open func updateUserRating() {
        
    }
}
