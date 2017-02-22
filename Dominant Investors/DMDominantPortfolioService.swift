//
//  DMDominantPortfolioService.swift
//  Dominant Investors
//
//  Created by Nekit on 18.02.17.
//  Copyright © 2017 Dominant. All rights reserved.
//

import UIKit

class DMDominantPortfolioService: NSObject, UITableViewDataSource, UITableViewDelegate{

    static let sharedInstance = DMDominantPortfolioService()
    
    var portfolios = [DMDominantPortfolioModel]()
    
    var tableView : UITableView?
    
    override init() {
        super.init()
        self.getDominantPortfolio { (portfolios) in
            self.portfolios = portfolios
            self.tableView?.reloadData()
        }
    }

    open func getDominantPortfolio(completion : @escaping ([DMDominantPortfolioModel]) -> Void) {
        DMQuickBloxService.sharedInstance.getDominantPortfolio(completion: completion)
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
        cell.setupWithDominant(stock: portfolios[indexPath.row])
        return cell
    }
}
