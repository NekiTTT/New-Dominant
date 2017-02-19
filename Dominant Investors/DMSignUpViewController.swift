//
//  DMSignUpViewController.swift
//  Dominant Investors
//
//  Created by Nekit on 19.02.17.
//  Copyright © 2017 Dominant. All rights reserved.
//

import UIKit

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
    
    // MARK : Actions
    
    @IBAction func signUpButtonPressed(sender : UIButton) {
        DMAPIService.sharedInstance.signUpWith(login: self.loginTextField.text!,
                                               email: self.emailTextField.text!,
                                               password: self.passwordTextField.text!,
                                               confirm: self.confirmPasswordTextField.text!) { (success) in
                                                
        }
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
