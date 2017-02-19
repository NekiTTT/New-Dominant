//
//  DMLoginViewController.swift
//  Dominant Investors
//
//  Created by Nekit on 19.02.17.
//  Copyright © 2017 Dominant. All rights reserved.
//

import UIKit

class DMLoginViewController: DMViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK : Private
    
    private func setupUI() {
        
    }
    
    // MARK : UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
 

}
