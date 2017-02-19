//
//  DMLaunchViewController.swift
//  Dominant Investors
//
//  Created by Nekit on 19.02.17.
//  Copyright © 2017 Dominant. All rights reserved.
//

import UIKit

class DMLaunchViewController: DMViewController {

    @IBOutlet weak var backgroundImage   : UIImageView!
    @IBOutlet weak var activityIndicator : UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        launchApp()
    }

    private func setupUI() {
        self.backgroundImage.image = Backgrounds().DMAuthScreensBackground
        self.activityIndicator.startAnimating()
    }
    
    private func launchApp() {
        let auth = UIStoryboard(name: "Authorization", bundle: nil).instantiateInitialViewController()
        self.present(auth!, animated: false, completion: nil)
    }

}
