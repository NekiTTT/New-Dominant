//
//  DMPersonalPortfolioService.swift
//  Dominant Investors
//
//  Created by Nekit on 18.02.17.
//  Copyright © 2017 Dominant. All rights reserved.
//

import UIKit

class DMPersonalPortfolioService: NSObject, UITableViewDataSource, UITableViewDelegate, DMStockCellDelegate {

    static let sharedInstance = DMPersonalPortfolioService()
    
    var portfolios     = [DMPersonalPortfolioModel]()
    var selectedTicker : StockSearchResult?
    var userInterface  : DMPortfolioUserInterface?
    
    var totalData = [String : Double]()
    var portfolioTotal  : Double = 0
    var portfolioMiddle : Double = 0
    var totalCell : DMPortfolioTotalCell?
  
    var ratingUploaded = false
    
    override init() {
        super.init()
        self.getPersonalPortfolio { (portfolios) in
            self.portfolios = portfolios
            self.userInterface?.reloadData()
        }
    }
    
    open func getPersonalPortfolio(completion : @escaping ([DMPersonalPortfolioModel]) -> Void) {
        DMQuickBloxService.sharedInstance.getPersonalPortfolio(completion: completion)
    }
    
    open func renewPersonalData() {
        self.ratingUploaded = false
        self.getPersonalPortfolio { (portfolios) in
            self.portfolios = portfolios
            self.userInterface?.reloadData()
        }
    }
    
    open func addNew() {
        let newStock = DMPersonalPortfolioModel.init(stockSearch: self.selectedTicker!)
        self.addNew(personalStock: newStock) { (portfolios) in
            DispatchQueue.main.async {
                self.selectedTicker = nil
                self.ratingUploaded = false
                self.portfolios.append(contentsOf: portfolios)
                self.userInterface?.reloadData()
            }
        }
    }
    
    open func clearPortfolio() {
        var IDs = [String]()
        for stock in self.portfolios {
            IDs.append(stock.id!)
        }
        self.ratingUploaded = false
        self.clearPortfolio(IDs: IDs) { (portfolios) in
            DispatchQueue.main.async {
                self.portfolios = portfolios
                self.userInterface?.reloadData()
            }
        }
    }
    
    
    // MARK: Private
    
    private func clearPortfolio(IDs : [String], completion : @escaping ([DMPersonalPortfolioModel]) -> Void) {
        DMQuickBloxService.sharedInstance.clearPortfolio(IDs : IDs, completion: completion)
    }
    
    private func addNew(personalStock : DMPersonalPortfolioModel, completion : @escaping ([DMPersonalPortfolioModel]) -> Void) {
         DMAPIService.sharedInstance.addNew(personalStock: personalStock, completion: completion)
    }
    
    private func updateUserRating() {
        if (totalData.values.count == self.portfolios.count) {
            self.totalCell?.setTotal(value: self.portfolioMiddle)
            if (!self.ratingUploaded) {
                self.ratingUploaded = true
                DMQuickBloxService.sharedInstance.updateUserRating(value: self.portfolioMiddle)
            }
        }
    }
    
    private func moreAboutStock(stock : DMPersonalPortfolioModel) {
        let controller = UIStoryboard(name: "Portfolio", bundle: nil).instantiateViewController(withIdentifier: "DMStockDetailViewController") as! DMStockDetailViewController
        
        SwiftStockKit.fetchStockForSymbol(symbol: stock.ticker!) { (stock) -> () in
            DispatchQueue.main.async {
                controller.stockSymbol = stock.symbol!
                controller.stock = stock
                self.userInterface?.showStockDetail(controller: controller)
            }
        }
    }
    
    private func deletePersonalStock(stock : DMPersonalPortfolioModel) {
        self.portfolios.remove(object: stock)
        self.totalData = [String : Double]()
        DMAPIService.sharedInstance.deletePersonalStock(ID: stock.id!) { (portfolios) in
            DispatchQueue.main.async {
                self.ratingUploaded = false
                self.userInterface?.reloadData()
            }
        }
    }
    
    // MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if (indexPath.row == self.portfolios.count) {
            return false
        }
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
          if (indexPath.row != self.portfolios.count) {
            let more = UITableViewRowAction(style: .normal, title: NSLocalizedString("More", comment: "")) { (action, indexPath) in
                tableView.setEditing(false, animated: true)
                self.moreAboutStock(stock: self.portfolios[indexPath.row])
            }
            more.backgroundColor = UIColor.blue
            
            let delete = UITableViewRowAction(style: .destructive, title: NSLocalizedString("Delete", comment: "")) { (action, indexPath) in
                let stock = self.portfolios[indexPath.row]
                self.deletePersonalStock(stock: stock)
                self.ratingUploaded = false
            }
            
            delete.backgroundColor = UIColor.red
            return [delete, more]
        } else {
            return nil
        }
    }
    
    // MARK: UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (portfolios.count != 0) {
            return portfolios.count + 1
        } else {
            self.userInterface?.didReloaded()
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (indexPath.row == portfolios.count) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DMPortfolioTotalCell") as! DMPortfolioTotalCell
            self.totalCell = cell
            self.userInterface?.didReloaded()
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DMStockCell") as! DMStockCell
        cell.delegate = self
        cell.setupWithPersonal(stock: portfolios[indexPath.row])
        return cell
    }
    
    // MARK: DMStockCellDelegate
    
    func setToTotalValue(ticker : String, value : Double) {
        totalData[ticker] = value
        calculateTotal()
    }
    
    private func calculateTotal() {
        self.portfolioTotal = 0
        self.portfolioMiddle = 0
        for value in totalData.values {
            self.portfolioTotal += value
        }
        if (self.totalData.values.count != 0) {
        self.portfolioMiddle = (self.portfolioTotal / Double(self.totalData.values.count)) }
        updateUserRating()
    }

}
