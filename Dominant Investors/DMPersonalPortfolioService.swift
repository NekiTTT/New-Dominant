//
//  DMPersonalPortfolioService.swift
//  Dominant Investors
//
//  Created by Nekit on 18.02.17.
//  Copyright © 2017 Dominant. All rights reserved.
//

import UIKit

class DMPersonalPortfolioService: NSObject, UITableViewDataSource, UITableViewDelegate {

    static let sharedInstance = DMPersonalPortfolioService()
    
    var portfolios = [DMPersonalPortfolioModel]()
    
    var tableView : UITableView?
    
    override init() {
        super.init()
        self.getPersonalPortfolio { (portfolios) in
            self.portfolios = portfolios
            self.tableView?.reloadData()
        }
    }
    
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
        DMAPIService.sharedInstance.getUserRatings { (ratings) in
            for rate in ratings {
                if (rate.id == DMAuthorizationManager.sharedInstance.userProfile.userID) {
                    
                    break
                } else {
                    // TODO : Create user portfoioTotal.
                }
            }
        }
    }
    
    // MARK : UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return portfolios.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DMStockCell") as! DMStockCell
        cell.setupWithPersonal(stock: portfolios[indexPath.row])
        return cell
    }

}
