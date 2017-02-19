//
//  DMLoginViewController.swift
//  Dominant Investors
//
//  Created by Nekit on 19.02.17.
//  Copyright © 2017 Dominant. All rights reserved.
//

import UIKit

class DMLoginViewController: DMViewController, UITextFieldDelegate {

    @IBOutlet weak var usernameTextField  : UITextField!
    @IBOutlet weak var passwordTextField  : UITextField!
    @IBOutlet weak var overlayView        : FXBlurView!
    @IBOutlet weak var createNewAccount   : UIButton!
    @IBOutlet var backgroundImageView     : UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK : Private
    
    private func setupUI() {
        drawBlurOverlay()
        configureLabels()
        configureTextFields()
    }
    
    private func drawBlurOverlay() {
        self.overlayView.clipsToBounds      = true
        self.overlayView.layer.cornerRadius = 7
        self.overlayView.isBlurEnabled      = true
        self.overlayView.blurRadius         = 20
        self.overlayView.isDynamic          = false
        self.overlayView.tintColor          = UIColor.lightGray
    }
    
    private func configureLabels() {
        let underlineAttriString = NSMutableAttributedString(string:"CREATE ACCOUNT", attributes:
            [NSUnderlineStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue])
        
        underlineAttriString.addAttribute(NSForegroundColorAttributeName, value: UIColor.white, range: NSRange.init(location: 0, length: underlineAttriString.length))
        underlineAttriString.addAttribute(NSFontAttributeName, value: Fonts.DMMyseoFont, range: NSRange.init(location: 0, length: underlineAttriString.length))
        
        createNewAccount.setAttributedTitle(underlineAttriString, for: .normal)
    }
    
    private func configureTextFields() {
    
        self.usernameTextField.attributedPlaceholder =
            NSAttributedString(string:"USERNAME",
                               attributes:[NSForegroundColorAttributeName: UIColor.white])
        self.passwordTextField.attributedPlaceholder =
            NSAttributedString(string:"PASSWORD",
                               attributes:[NSForegroundColorAttributeName: UIColor.white])
        
        self.usernameTextField.delegate = self
        self.passwordTextField.delegate = self
    }
    
    // MARK : Actions
    
    @IBAction func loginButtonPressed(sender : UIButton) {
        
    }
    
    @IBAction func signUpButtonPressed(sender : UIButton) {
        
    }
    
    // MARK : UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.placeholder = nil;
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.configureTextFields()
    }
 

}
