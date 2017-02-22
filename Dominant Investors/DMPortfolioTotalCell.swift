//
//  DMPortfolioTotalCell.swift
//  Dominant Investors
//
//  Created by Nekit on 19.02.17.
//  Copyright © 2017 Dominant. All rights reserved.
//

import UIKit

class DMPortfolioTotalCell: UITableViewCell {

    @IBOutlet weak var totalLabel : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = self.contentView.backgroundColor;
    }

}
