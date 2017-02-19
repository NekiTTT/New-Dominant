//
//  DMSignUpViewController.swift
//  Dominant Investors
//
//  Created by Nekit on 19.02.17.
//  Copyright © 2017 Dominant. All rights reserved.
//

import UIKit

class DMSignUpViewController: DMViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    // MARK : Private
    
    private func setupUI() {
        
    }
    
    // MARK : UITextFieldDelegate

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
}
