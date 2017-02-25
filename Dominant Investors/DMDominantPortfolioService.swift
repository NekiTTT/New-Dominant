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
    var portfolioController : DMPortfolioViewController!
    
    var userInterface : DMPortfolioUserInterface!
    
    override init() {
        super.init()
        self.getDominantPortfolio { (portfolios) in
            self.portfolios = portfolios
            self.userInterface?.reloadData()
        }
    }

    open func getDominantPortfolio(completion : @escaping ([DMDominantPortfolioModel]) -> Void) {
        DMQuickBloxService.sharedInstance.getDominantPortfolio(completion: completion)
    }
    
    // MARK: UITableViewDelegate
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        if (tableView.cellForRow(at: indexPath) as? DMStockCell) != nil {
            let more = UITableViewRowAction(style: .normal, title: NSLocalizedString("More", comment: "")) { (action, indexPath) in
                tableView.setEditing(false, animated: true)
                self.moreAboutStock(stock: self.portfolios[indexPath.row])
            }
            more.backgroundColor = UIColor.blue
            return [more]
        } else {
            return nil
        }
    }
    
    
    // MARK: UITableViewDataSource
    
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
    
    // MARK: DMStockCellDelegate
    
    func setToTotalValue(ticker : String, value : Double) {
        totalData[ticker] = value
        calculateTotal()
    }
    
    // MARK: Private
    
    private func calculateTotal() {
        self.portfolioTotal = 0
        for value in totalData.values {
            self.portfolioTotal += value
        }
        self.portfolioTotal = (self.portfolioTotal / Double(self.totalData.values.count))
        self.totalCell?.setTotal(value: self.portfolioTotal)
    }
    
    private func moreAboutStock(stock : DMDominantPortfolioModel) {
        let controller = UIStoryboard(name: "Portfolio", bundle: nil).instantiateViewController(withIdentifier: "DMStockDetailViewController") as! DMStockDetailViewController
        
        SwiftStockKit.fetchStockForSymbol(symbol: stock.ticker!) { (stock) -> () in
            DispatchQueue.main.async {
                controller.stockSymbol = stock.symbol!
                controller.stock = stock
                self.userInterface.showStockDetail(controller: controller)
            }
        }
    }
}
