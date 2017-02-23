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
    
    // MARK : UIAlertController
    
    open func showAlertWith(title : String, message : String, cancelButton : Bool) {
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction.init(title: NSLocalizedString("Ok", comment: ""), style: .default, handler: { (action) in
            self.okAction()
        }))
        
        if (cancelButton) {
            alert.addAction(UIAlertAction.init(title: NSLocalizedString("Cancel", comment: ""), style: .destructive, handler: { (action) in
                self.cancelAction()
            }))
        }
        
        self.present(alert, animated: true) {
            
        }
    }
    
    open func okAction() {
        
    }
    
    open func cancelAction() {
        
    }
}
