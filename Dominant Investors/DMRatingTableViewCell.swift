//
//  DMViewController.swift
//  Dominant Investors
//
//  Created by Nekit on 18.02.17.
//  Copyright © 2017 Dominant. All rights reserved.
//

import UIKit

class DMRatingTableViewCell: UITableViewCell {

    @IBOutlet weak var  positionLabel : UILabel!
    @IBOutlet weak var  investorLabel : UILabel!
    @IBOutlet weak var  overallLabel  : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.clear
    }
    
    open func setupWith(model : DMRatingModel) {
        self.positionLabel.text = String(format : "%d", model.position)
        self.investorLabel.text = model.userName
        self.overallLabel.text  = String(format : "%.2f", model.totalValue)
        
        if (model.userID == DMAuthorizationManager.sharedInstance.userProfile.userID) {
            self.backgroundColor = UIColor(colorLiteralRed: 1, green: 1, blue: 1, alpha: 0.4)
        }
    }

}
