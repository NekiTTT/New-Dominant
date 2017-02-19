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
    @IBOutlet  weak var searchBar: UITextField!
    @IBOutlet  weak var priceTextField: UITextField!
    @IBOutlet  weak var searchDropdown: UIView!
    @IBOutlet  weak var searchBarContainer: UIView!
    @IBOutlet  weak var tickerFieldContainer: UIView!
    @IBOutlet  weak var priceFieldContainer: UIView!
    @IBOutlet  weak var dateFieldContainer: UIView!
    @IBOutlet  weak var dateTextField: UITextField!
    
    @IBOutlet  weak var segmentSelector : UISegmentedControl!
    @IBOutlet  weak var FisrstHeight : NSLayoutConstraint!
    @IBOutlet  weak var SecondHeight : NSLayoutConstraint!
    @IBOutlet  weak var dominantImageHeight : NSLayoutConstraint!
    
    @IBOutlet  weak var firstContainer: UIView!
    @IBOutlet  weak var secondContainer: UIView!
    @IBOutlet  weak var ratingContainer: UIView!
    @IBOutlet  weak var dominantImageContainer : UIView!
    
    @IBOutlet  weak var dominantContainer: UIView!
    @IBOutlet  weak var personalContainer: UIView!
    
    @IBOutlet  weak var fisrtLabel  : UILabel!
    @IBOutlet  weak var secondLabel : UILabel!
    @IBOutlet  weak var thirdLabel  : UILabel!
    @IBOutlet  weak var fourthLabel : UILabel!
    
    @IBOutlet  weak var dropShadowView : UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK : Private

    // MARK : Actions
    
    @IBAction func portfolioTypeChanged(sender : UISegmentedControl) {
        
    }

}
