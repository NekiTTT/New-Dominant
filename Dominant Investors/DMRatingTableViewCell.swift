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
        
    }

}
