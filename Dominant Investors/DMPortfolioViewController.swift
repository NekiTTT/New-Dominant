//
//  DMPortfolioViewController.swift
//  Dominant Investors
//
//  Created by Nekit on 19.02.17.
//  Copyright © 2017 Dominant. All rights reserved.
//

import UIKit

enum DMPortfolioType : Int {
    case DMPersonalPortfolio = 0
    case DMDominantPortfolio = 1
}

class DMPortfolioViewController: DMViewController, DMDropdownListDelegate {

    var refreshControl: UIRefreshControl!
    var dropdownViewController : DMDropdownViewController!
    var searchResults = [StockSearchResult]()
    var total = 0.0

    var formatter = DateFormatter()
    
    var portfolioType  = DMPortfolioType.DMPersonalPortfolio
    
    // MARK: Outlets
    @IBOutlet  weak var tickerField              : UITextField!
    
    @IBOutlet  weak var firstHeaderHeight        : NSLayoutConstraint!
    @IBOutlet  weak var secondHeaderHeight       : NSLayoutConstraint!
    @IBOutlet  weak var dropdownListHeight       : NSLayoutConstraint!
    
    @IBOutlet  weak var portfolioTypeSwitcher    : UISegmentedControl!
    
    @IBOutlet  weak var searchDropdown         : UIView!
    @IBOutlet  weak var firstContainer         : UIView!
    @IBOutlet  weak var secondContainer        : UIView!
    @IBOutlet  weak var dominantImageContainer : UIView!
    @IBOutlet  weak var searchBarContainer     : UIView!
    @IBOutlet  weak var dropShadowView         : UIView!
    
    @IBOutlet  weak var fisrtColumnTitle    : UILabel!
    @IBOutlet  weak var secondColumnTitle   : UILabel!
    @IBOutlet  weak var thirdColumnTitle    : UILabel!
    @IBOutlet  weak var fourthColumnTitle   : UILabel!
    
    @IBOutlet  weak var dominantButton      : UIView!
    @IBOutlet  weak var personalButton      : UIView!
    
    @IBOutlet  weak var tableView           : UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        showPersonal()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "containerSegue") {
            self.dropdownViewController = segue.destination as! DMDropdownViewController
            self.dropdownViewController.portfolioController = self
        }
    }

    // MARK : Private
    
    private func setupUI() {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.tableView.register(UINib(nibName: "DMStockCell", bundle: Bundle.main), forCellReuseIdentifier: "DMStockCell")
        self.tableView.register(UINib(nibName: "DMPortfolioTotalCell", bundle: Bundle.main), forCellReuseIdentifier: "DMPortfolioTotalCell")
    
        self.personalButton.layer.borderWidth = 1
        self.dominantButton.layer.borderWidth = 1
        
        self.firstContainer.layer.borderWidth = 0.5
        self.firstContainer.layer.borderColor = UIColor.lightGray.cgColor
        
        self.dominantImageContainer.layer.borderWidth = 0.5
        self.dominantImageContainer.layer.borderColor = UIColor.lightGray.cgColor
        
        DMPersonalPortfolioService.sharedInstance.tableView = self.tableView
        DMDominantPortfolioService.sharedInstance.tableView = self.tableView
    }
    
    private func showPersonal() {
        
        self.tableView.delegate   = DMPersonalPortfolioService.sharedInstance
        self.tableView.dataSource = DMPersonalPortfolioService.sharedInstance
        
        self.tableView.reloadData()
        
        UIView.animate(withDuration: 1) {
            self.firstHeaderHeight.constant  = 50
            self.secondHeaderHeight.constant = 0
            self.firstContainer.alpha = 1
            self.dominantImageContainer.alpha = 0
            
            self.view.setNeedsLayout()
            self.view.layoutIfNeeded()
            
            self.dominantButton.layer.borderColor = UIColor.clear.cgColor
            self.personalButton.layer.borderColor = UIColor.red.cgColor
        }
       
        self.setColumnTitles(titles: ["TICKER","BUY\nPOINT $","CURRENT PRICE $","PROFITABILITY"])
    
        self.portfolioType = .DMPersonalPortfolio
    }
    
    private func showDominant() {
        
        self.tableView.delegate   = DMDominantPortfolioService.sharedInstance
        self.tableView.dataSource = DMDominantPortfolioService.sharedInstance
        
        self.tableView.reloadData()
        
        UIView.animate(withDuration: 1) {
            self.firstHeaderHeight.constant  = 0
            self.dominantImageContainer.alpha = 1
            self.firstContainer.alpha = 0
            self.secondHeaderHeight.constant = 170
            
            self.view.setNeedsLayout()
            self.view.layoutIfNeeded()
        }
        
        self.dominantButton.layer.borderColor = UIColor.red.cgColor
        self.personalButton.layer.borderColor = UIColor.clear.cgColor
  
        self.setColumnTitles(titles: ["TICKER","EXCHANGE","CURRENT PRICE $","PROFITABILITY"])
        
        self.portfolioType = .DMDominantPortfolio
    }
    
    private func setColumnTitles(titles : [String]) {
        self.fisrtColumnTitle.text  = titles[0]
        self.secondColumnTitle.text = titles[1]
        self.thirdColumnTitle.text  = titles[2]
        self.fourthColumnTitle.text = titles[3]
    }

    // MARK : Actions
    
    @IBAction func portfolioTypeChanged(sender : UISegmentedControl) {
        self.portfolioType == .DMPersonalPortfolio ? showDominant() : showPersonal()
    }
    
    @IBAction func addTickerAction(sender : UIButton) {
        if (DMPersonalPortfolioService.sharedInstance.selectedTicker == nil) { return }
        DMPersonalPortfolioService.sharedInstance.addNew()
        self.tickerField.text = ""
    }
    
    @IBAction func createNewPortfolio(sender : UIButton) {
        
    }
    
    private func showDropdownList(listHeight : Int, tickers : [StockSearchResult]) {
        self.dropdownViewController.dataSource = tickers
        self.dropdownViewController.tableView.reloadData()
        
        UIView.animate(withDuration: 0.4) {
            self.dropdownListHeight.constant = CGFloat(30 * listHeight)
            self.view.setNeedsLayout()
            self.view.layoutIfNeeded()
        }
    }
    
    private func hideDropdownList() {
        UIView.animate(withDuration: 0.4) {
            self.dropdownListHeight.constant = 0
            self.view.setNeedsLayout()
            self.view.layoutIfNeeded()
        }
    }
    
    // MARK : UITextFieldDelegate (Actions)
    
    @IBAction func tickerInputHandler(sender : UITextField) {
        if (sender.text?.characters.count == 0) {
            DMPersonalPortfolioService.sharedInstance.selectedTicker = nil
            hideDropdownList()
        } else {
            SwiftStockKit.fetchStocksFromSearchTerm(term: sender.text!) { (stockInfoArray) -> () in
                DispatchQueue.main.async {
                    self.showDropdownList(listHeight: stockInfoArray.count, tickers: stockInfoArray)
                }
            }
        }
    }
    
    // MARK : DMDropdownListDelegate
    
    func tickerDidSelected(stock : StockSearchResult) {
        self.hideDropdownList()
        self.tickerField.text = stock.symbol
        DMPersonalPortfolioService.sharedInstance.selectedTicker = stock
        self.tickerField.resignFirstResponder()
    }
    
}
