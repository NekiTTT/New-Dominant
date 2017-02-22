//
//  DMViewController.swift
//  Dominant Investors
//
//  Created by Nekit on 18.02.17.
//  Copyright © 2017 Dominant. All rights reserved.
//

import UIKit

class DMViewController: UIViewController {

    var DMAuthScreensBackground : UIImage {
        get {
            switch UIDevice.current.userInterfaceIdiom {
            case .phone:
                return UIImage(named: "ratingIPHONE")!
            case .pad:
                return UIImage(named: "ratingIPAD")!
            case .unspecified:
                return UIImage(named: "ratingIPHONE")!
            default:
                return UIImage(named: "ratingIPAD")!
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK : Own func
    
    private func showAlertWith(text : String) {
        
    }
    
    

}
