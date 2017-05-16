//
//  DMAuthorizationManager.swift
//  Dominant Investors
//
//  Created by Nekit on 18.02.17.
//  Copyright © 2017 Dominant. All rights reserved.
//

import UIKit
import Quickblox

class DMAuthorizationManager: NSObject {

    static let sharedInstance = DMAuthorizationManager()
    
    var userProfile : DMUserProfileModel!
    
    override init() {
        super.init()
        if (self.isAuthorized()) {
            if let data = UserDefaults.standard.object(forKey: "Authorized") as? NSData {
                if let profile = NSKeyedUnarchiver.unarchiveObject(with: data as Data) as? DMUserProfileModel {
                    self.userProfile = profile
                }
            }
        }
    }
    
    open func isAuthorized() -> Bool {
        
        if (UserDefaults.standard.value(forKey: "Authorized") != nil) {
            if (UserDefaults.standard.value(forKey: "Authorized") is NSData && QBSession.current().isTokenValid) {
                return true
            }
        }
        
        return false
    }
    
    open func loginWith(login : String, password : String, completion : @escaping (Bool, String?) -> Void) {
        DMQuickBloxService.sharedInstance.loginWith(login: login, password: password, competion: completion)
    }
    
    open func signUpWith(login : String, email : String, password : String, confirm : String , completion : @escaping (Bool, String?) -> Void) {
        DMQuickBloxService.sharedInstance.signUpWith(login: login, email: email, password: password, confirm: confirm, completion: completion)
    }
    
    open func signOut() {
        UserDefaults.standard.setValue(nil, forKey: "Authorized")
        DMQuickBloxService.sharedInstance.signOut()
    }
    
}
