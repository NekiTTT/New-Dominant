//
//  DMPortfolioViewController.swift
//  Dominant Investors
//
//  Created by Nekit on 19.02.17.
//  Copyright © 2017 Dominant. All rights reserved.
//

import UIKit

class DMPortfolioViewController: DMViewController {

    var refreshControl: UIRefreshControl!
    var dropdownViewController: DMDropdownViewController!
    var searchResults: [StockSearchResult] = []
    var total = 0.0

    var formatter = DateFormatter()
    
    
    // MARK: Outlets
    @IBOutlet  weak var tickerField              : UITextField!
    
    @IBOutlet  weak var searchDropdown           : UIView!
    @IBOutlet  weak var tickerFieldContainer     : UIView!
    
    @IBOutlet  weak var portfolioTypeSwitcher    : UISegmentedControl!
    @IBOutlet  weak var firstHeaderHeight        : NSLayoutConstraint!
    @IBOutlet  weak var secondHeaderHeight       : NSLayoutConstraint!
    
    
    @IBOutlet  weak var firstContainer         : UIView!
    @IBOutlet  weak var secondContainer        : UIView!
    @IBOutlet  weak var dominantImageContainer : UIView!
    @IBOutlet  weak var searchBarContainer     : UIView!
    
    @IBOutlet  weak var fisrtColumnTitle    : UILabel!
    @IBOutlet  weak var secondColumnTitle   : UILabel!
    @IBOutlet  weak var thirdColumnTitle    : UILabel!
    @IBOutlet  weak var fourthColumnTitle   : UILabel!
    
    @IBOutlet  weak var dropShadowView : UIView!
    
    @IBOutlet  weak var tableView : UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
    }
    
    // MARK : Private
    
    private func setupUI() {
        
    }

    // MARK : Actions
    
    @IBAction func portfolioTypeChanged(sender : UISegmentedControl) {
        
    }

}
