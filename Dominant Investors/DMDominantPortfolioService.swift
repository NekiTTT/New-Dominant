//
//  DMDominantPortfolioService.swift
//  Dominant Investors
//
//  Created by Nekit on 18.02.17.
//  Copyright © 2017 Dominant. All rights reserved.
//

import UIKit

class DMDominantPortfolioService: NSObject, UITableViewDataSource, UITableViewDelegate, DMStockCellDelegate {

    static let sharedInstance = DMDominantPortfolioService()
    
    var portfolios = [DMDominantPortfolioModel]()
    var totalData = [String : Double]()
    var portfolioTotal : Double = 0
    var totalCell : DMPortfolioTotalCell?
    
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
    
    // MARK : UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    // MARK : UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return portfolios.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (indexPath.row == portfolios.count) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DMPortfolioTotalCell") as! DMPortfolioTotalCell
            self.totalCell = cell
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DMStockCell") as! DMStockCell
        cell.delegate = self
        cell.setupWithDominant(stock: portfolios[indexPath.row])
        return cell
    }
    
    // MARK : DMStockCellDelegate
    
    func setToTotalValue(ticker : String, value : Double) {
        totalData[ticker] = value
        calculateTotal()
    }
    
    private func calculateTotal() {
        self.portfolioTotal = 0
        for value in totalData.values {
            self.portfolioTotal += value
        }
        self.totalCell?.totalLabel.text = String(format: "%.2f%", self.portfolioTotal).appending("%")
    }
}
