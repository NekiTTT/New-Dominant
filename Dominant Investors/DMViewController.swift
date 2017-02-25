//
//  DMViewController.swift
//  Dominant Investors
//
//  Created by Nekit on 18.02.17.
//  Copyright © 2017 Dominant. All rights reserved.
//  SUPERCLASS FOR ALL CONTROLLERS IN APP.

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
        
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { context in
            context.viewController(forKey: UITransitionContextViewControllerKey.from)
        }, completion: { context in
            self.view.setNeedsLayout()
            self.view.layoutIfNeeded()
        })
    }
    
    
    // MARK: UIAlertController
    
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
