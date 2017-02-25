//
//  DMSignUpViewController.swift
//  Dominant Investors
//
//  Created by Nekit on 19.02.17.
//  Copyright © 2017 Dominant. All rights reserved.
//

import UIKit
import MBProgressHUD

class DMSignUpViewController: DMViewController, UITextFieldDelegate {

    @IBOutlet weak var signUpButton              : UIButton!
    @IBOutlet weak var alreadyHaveAccount        : UIButton!
    
    @IBOutlet weak var loginTextField            : UITextField!
    @IBOutlet weak var emailTextField            : UITextField!
    @IBOutlet weak var passwordTextField         : UITextField!
    @IBOutlet weak var confirmPasswordTextField  : UITextField!
    
    @IBOutlet var backgroundImageView            : UIImageView!
    @IBOutlet var overlayView                    : FXBlurView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }


    // MARK : Private
    
    private func setupUI() {
        configureTextFields()
        drawBlurOverlay()
    }
    
    private func drawBlurOverlay() {
        self.overlayView.clipsToBounds      = true
        self.overlayView.layer.cornerRadius = 7
        self.overlayView.isBlurEnabled      = true
        self.overlayView.blurRadius         = 20
        self.overlayView.isDynamic          = false
        self.overlayView.tintColor          = UIColor.lightGray
    }

    
    private func configureTextFields() {

    }
    
    private func handleSignUp () {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        DMAuthorizationManager.sharedInstance.signUpWith(login : self.loginTextField.text!,
                                                         email    : self.emailTextField.text!,
                                                         password : self.passwordTextField.text!,
                                                         confirm  : self.confirmPasswordTextField.text!) { (success, error) in
                                                            DispatchQueue.main.async {
                                                                MBProgressHUD.hide(for: self.view, animated: true)
                                                                if (success) {
                                                                    self.dismiss(animated: true, completion: nil)
                                                                }
                                                            }
        }
    }
    
    // MARK : Actions
    
    @IBAction func signUpButtonPressed(sender : UIButton) {
        
        if (self.passwordTextField.text!.characters.count < 8) {
            self.showAlertWith(title: NSLocalizedString("Sign up error", comment: ""),
                               message: NSLocalizedString("Password must be at least 8 characters", comment: ""),
                               cancelButton: false)
            
            return
        } else if (self.passwordTextField.text != self.confirmPasswordTextField.text) {
            self.showAlertWith(title: NSLocalizedString("Sign up error", comment: ""),
                               message: NSLocalizedString("Password not match", comment: ""),
                               cancelButton: false)
            return
        } else if (self.loginTextField.text!.characters.count < 4) {
            self.showAlertWith(title: NSLocalizedString("Sign up error", comment: ""),
                               message: NSLocalizedString("Username must be at least 4 characters", comment: ""),
                               cancelButton: false)
            return
        }
        
        handleSignUp()
    }
    
    @IBAction func backToLoginButtonPressed(sender : UIButton) {
        self.dismiss(animated: true, completion: nil)
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
