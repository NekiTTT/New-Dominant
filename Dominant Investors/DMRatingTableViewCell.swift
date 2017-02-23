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
            self.backgroundColor = UIColor(colorLiteralRed: 0, green: 255, blue: 0, alpha: 0.25)
        }
        
        model.totalValue <= 0 ? (self.overallLabel.textColor = UIColor.red) : (self.overallLabel.textColor = UIColor.init(red: 120/255, green: 187/255, blue: 50/255, alpha: 1))
    }

}
