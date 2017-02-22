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

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func setupWithDominant(stock : DMDominantPortfolioModel) {
        self.ticker.text = stock.ticker
        self.exchangeOrBuyPoint.text = stock.exchange
        
        self.profitability.text = ""
        self.currentPrice.text  = ""
        self.investmentPeriod.text = "(12 MONTH)"
    }
    
    public func setupWithPersonal(stock: DMPersonalPortfolioModel) {
        
    }
        
}


