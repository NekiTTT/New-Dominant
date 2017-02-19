//
//  DMCompanyCollectionCell.swift
//  Dominant Investors
//
//  Created by Nekit on 18.02.17.
//  Copyright © 2017 Dominant. All rights reserved.
//


import Foundation
import UIKit

class DMCompanyCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var companyImage : UIImageView!
    @IBOutlet weak var companyNameLabel : UILabel!
    @IBOutlet weak var activity : UIActivityIndicatorView!
    
    override func awakeFromNib() {
        activity.startAnimating()
        super.awakeFromNib()
    }
    
    open func setupWith(model : DMCompanyModel) {
        
    }

    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.activity.startAnimating()
        self.activity.isHidden = false
        self.companyImage.image = nil
    }
}

