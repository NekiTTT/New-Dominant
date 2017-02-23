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
    
    var totalData = [String : Double]()
    var portfolioTotal : Double = 0
    var totalCell : DMPortfolioTotalCell?
    
    var tableView : UITableView?
    var ratingUploaded = false
    
    override init() {
        super.init()
        self.getPersonalPortfolio { (portfolios) in
            self.portfolios = portfolios.reduce([],{ [$1] + $0 })
            self.tableView?.reloadData()
        }
    }
    
    open func getPersonalPortfolio(completion : @escaping ([DMPersonalPortfolioModel]) -> Void) {
        DMQuickBloxService.sharedInstance.getPersonalPortfolio(completion: completion)
    }
    
    open func addNew() {
        let newStock = DMPersonalPortfolioModel.init(stockSearch: self.selectedTicker!)
        self.addNew(personalStock: newStock) { (portfolios) in
            DispatchQueue.main.async {
                self.selectedTicker = nil
                self.portfolios.append(contentsOf: portfolios)
                self.portfolios = self.portfolios.reduce([],{ [$1] + $0 })
                self.tableView?.reloadData()
            }
        }
    }
    
    open func clearPortfolio() {
        self.clearPortfolio { (portfolios) in
            DispatchQueue.main.async {
                self.portfolios = portfolios.reduce([],{ [$1] + $0 })
                self.tableView?.reloadData()
            }
        }
    }
    
    open func updateUserRating() {
        
    }
    
    // MARK : Private
    
    private func clearPortfolio(completion : @escaping ([DMPersonalPortfolioModel]) -> Void) {
        DMQuickBloxService.sharedInstance.clearPortfolio(IDs : [String](), completion: completion)
    }
    
    private func addNew(personalStock : DMPersonalPortfolioModel, completion : @escaping ([DMPersonalPortfolioModel]) -> Void) {
        DMQuickBloxService.sharedInstance.addNew(personalStock: personalStock, completion: completion)
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
        cell.setupWithPersonal(stock: portfolios[indexPath.row])
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
        if (totalData.values.count == self.portfolios.count) {
            self.totalCell?.setTotal(value: self.portfolioTotal)
            if (!self.ratingUploaded) {
                self.ratingUploaded = true
                DMQuickBloxService.sharedInstance.updateUserRating(value: self.portfolioTotal)
            }
        }
    }

}
