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
        DMQuickBloxService.sharedInstance.getPersonalPortfolio(completion: completion)
    }
    
    open func getDominantPortfolio(completion : ([DMDominantPortfolioModel]) -> Void) {
        DMQuickBloxService.sharedInstance.getDominantPortfolio(completion: completion)
    }
    
    open func getUserRatings(completion : ([DMRatingModel]) -> Void) {
        DMQuickBloxService.sharedInstance.getUserRatings(completion: completion)
    }
    
    open func getAnalyticsCompanies(completion : ([DMCompanyModel]) -> Void) {
        DMQuickBloxService.sharedInstance.getAnalyticsCompanies(completion: completion)
    }
    
    open func getInvestmentSignals(completion : ([DMInvestmentSignalModel]) -> Void) {
        DMQuickBloxService.sharedInstance.getInvestmentSignals(completion: completion)
    }
    
    // MARK : Set Data
    
    open func addNew(personalStock : DMPersonalPortfolioModel, completion : ([DMPersonalPortfolioModel]) -> Void) {
        DMQuickBloxService.sharedInstance.addNew(personalStock: personalStock, completion: completion)
    }
    
    open func clearPortfolio(completion : ([DMPersonalPortfolioModel]) -> Void) {
        DMQuickBloxService.sharedInstance.clearPortfolio(completion: completion)
    }
    
    open func loginWith(login : String, password : String, completion : (Bool, String?) -> Void) {
        DMQuickBloxService.sharedInstance.loginWith(login: login, password: password, competion: completion)
    }
    
    open func signUpWith(login : String, email : String, password : String, confirm : String , completion : (Bool, String?) -> Void) {
        DMQuickBloxService.sharedInstance.signUpWith(login: login, email: email, password: password, confirm: confirm, completion: completion)
    }
    
    open func updateUserRating() {
        DMQuickBloxService.sharedInstance.updateUserRating()
    }
    
    
}
