//
//  StockCell.swift
//  SwiftStockExample
//
//  Created by Mike Ackley on 5/3/15.
//  Copyright (c) 2015 Michael Ackley. All rights reserved.
//

import UIKit

class DMStockCell: UITableViewCell {

    @IBOutlet weak var ticker             : UILabel!
    @IBOutlet weak var exchangeOrBuyPoint : UILabel!
    @IBOutlet weak var currentPrice       : UILabel!
    @IBOutlet weak var profitability      : UILabel!
    @IBOutlet weak var investmentPeriod   : UILabel!

    var delegate : DMStockCellDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func setupWithDominant(stock : DMDominantPortfolioModel) {
        self.ticker.text = stock.ticker
        self.exchangeOrBuyPoint.text = stock.exchange
        
        SwiftStockKit.fetchChartPoints(symbol: stock.ticker!, range: .OneYear) { (chartPoints) in
            DispatchQueue.main.async {
                let yearAgoPrice = Double(chartPoints.first!.close!)
                let currentPrice = Double(chartPoints.last!.close!)
                self.currentPrice.text  = String(format: "%.2f", currentPrice)
                let profitability = DMCalculationService.sharedInstance.calculateProfitWith(oldPrice: yearAgoPrice, currentPrice: currentPrice)
                self.profitability.text = String(format: "%.2f", profitability).appending("%")
            
                self.delegate.setToTotalValue(ticker: stock.id!, value: profitability)
            }
        }
        
        self.investmentPeriod.text = NSLocalizedString("(12 MONTH)", comment: "")
    }
    
    public func setupWithPersonal(stock: DMPersonalPortfolioModel) {
        self.ticker.text = stock.ticker
        self.exchangeOrBuyPoint.text = stock.entry_price
        self.investmentPeriod.text = DMDateService.sharedInstance.differenceBetweenDates(dateOne: stock.entry_date!, dateTwo: Date())
        
        SwiftStockKit.fetchChartPoints(symbol: stock.ticker!, range: .OneYear) { (chartPoints) in
            DispatchQueue.main.async {
                let currentPrice = Double(chartPoints.last!.close!)
                self.currentPrice.text  = String(format: "%.2f", currentPrice)
                let profitability = DMCalculationService.sharedInstance.calculateProfitWith(oldPrice: Double(stock.entry_price!)!, currentPrice: currentPrice)
                self.profitability.text = String(format: "%.2f", profitability).appending("%")
                self.delegate.setToTotalValue(ticker: stock.id!, value: profitability)
            }
        }
    }
        
}

