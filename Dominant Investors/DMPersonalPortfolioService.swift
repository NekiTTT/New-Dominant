//
//  DMPersonalPortfolioService.swift
//  Dominant Investors
//
//  Created by Nekit on 18.02.17.
//  Copyright © 2017 Dominant. All rights reserved.
//

import UIKit

class DMPersonalPortfolioService: NSObject {

    static let sharedInstance = DMPersonalPortfolioService()
    
    open func getPersonalPortfolio(completion : @escaping ([DMPersonalPortfolioModel]) -> Void) {
        DMQuickBloxService.sharedInstance.getPersonalPortfolio(completion: completion)
    }
    
    open func addNew(personalStock : DMPersonalPortfolioModel, completion : ([DMPersonalPortfolioModel]) -> Void) {
        DMQuickBloxService.sharedInstance.addNew(personalStock: personalStock, completion: completion)
    }
    
    open func clearPortfolio(completion : @escaping ([DMPersonalPortfolioModel]) -> Void) {
        DMQuickBloxService.sharedInstance.clearPortfolio(IDs : [String](), completion: completion)
    }
    
    open func updateUserRating() {
        DMQuickBloxService.sharedInstance.updateUserRating()
    }

}
