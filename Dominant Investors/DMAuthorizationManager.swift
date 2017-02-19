//
//  DMAuthorizationManager.swift
//  Dominant Investors
//
//  Created by Nekit on 18.02.17.
//  Copyright © 2017 Dominant. All rights reserved.
//

import UIKit

class DMAuthorizationManager: NSObject {

    static let sharedInstance = DMAuthorizationManager()
    
    var userProfile : DMUserProfileModel!
    
    open func isAuthorized() -> Bool {
        return false
    }
    
    open func loginWith(login : String, password : String, completion : @escaping (Bool, String?) -> Void) {
        DMQuickBloxService.sharedInstance.loginWith(login: login, password: password, competion: completion)
    }
    
    open func signUpWith(login : String, email : String, password : String, confirm : String , completion : @escaping (Bool, String?) -> Void) {
        DMQuickBloxService.sharedInstance.signUpWith(login: login, email: email, password: password, confirm: confirm, completion: completion)
    }
    
}
