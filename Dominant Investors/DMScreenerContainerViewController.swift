//
//  DMScreenerContainerViewController.swift
//  Dominant Investors
//
//  Created by ios_nikitos on 21.11.17.
//  Copyright © 2017 Dominant. All rights reserved.
//

import UIKit

class DMScreenerContainerViewController: DMViewController {

    @IBOutlet  weak var screenerSelector  : UISegmentedControl!
    @IBOutlet  weak var screenerContainer : UIView!
    @IBOutlet  weak var cryptoContainer   : UIView!
    @IBOutlet  weak var stockView         : UIView!
    @IBOutlet  weak var cryptoView        : UIView!
    
    @IBOutlet  weak var stockLabel         : UILabel!
    @IBOutlet  weak var cryptoLabel        : UILabel!
    
    
    
    //MARK: ViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.screenerSelector.selectedSegmentIndex = 0
        self.setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    //MARK: Actions
    
    @IBAction func screenerSelectorValueChanged(sender : UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            self.showScrenner()
        } else {
            self.showCryptoScreener()
        }
    }
    
    //MARK: Private
    
    fileprivate func setupUI() {
        self.stockView.layer.borderWidth = 1.0
        self.cryptoView.layer.borderWidth = 1.0
        self.stockView.layer.borderColor = UIColor.red.cgColor
        self.cryptoView.layer.borderColor = UIColor.clear.cgColor
        
        self.stockLabel.text = "STOCK SCREENER".localizedUppercase
        self.cryptoLabel.text = "CRYPTO SCREENER".localizedUppercase
        
        self.screenerContainer.alpha = 1
        self.cryptoContainer.alpha = 0
        self.cryptoContainer.isHidden = true
    }
    
    fileprivate func showScrenner() {
        self.stockView.layer.borderColor = UIColor.red.cgColor
        self.cryptoView.layer.borderColor = UIColor.clear.cgColor
        UIView.animate(withDuration: 0.3, animations: {
            self.screenerContainer.alpha = 1
            self.cryptoContainer.alpha = 0
        }) { (completed) in
            self.screenerContainer.isHidden = false
            self.cryptoContainer.isHidden = true
        }
    }
    
    fileprivate func showCryptoScreener() {
        self.stockView.layer.borderColor = UIColor.clear.cgColor
        self.cryptoView.layer.borderColor = UIColor.red.cgColor
        UIView.animate(withDuration: 0.3, animations: {
            self.screenerContainer.alpha = 0
            self.cryptoContainer.alpha = 1
        }) { (completed) in
            self.screenerContainer.isHidden = true
            self.cryptoContainer.isHidden = false
        }
    }
    
}
