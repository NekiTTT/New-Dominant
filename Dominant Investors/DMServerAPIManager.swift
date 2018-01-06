//
//  DMServerAPIManager.swift
//  Dominant Investors
//
//  Created by ios_nikitos on 06.01.18.
//  Copyright © 2018 Dominant. All rights reserved.
//

import Foundation
import SystemConfiguration
import Alamofire

class DMServerAPIManager : NSObject {
    
    static let sharedInstance = DMServerAPIManager()
    var reachability : NetworkReachabilityManager!
    
    override init() {
        super.init()
        self.setupReachability()
    }
    
    //MARK: Reachability
    
    private func setupReachability() {
        self.reachability = NetworkReachabilityManager.init(host: String(format : "%@/%@/" , Network.baseURL, Network.APIVersion))
        self.reachability.listener = { status in
            
        }
        self.reachability.startListening()
    }
    
    open func isInternetAvailable() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
    
    //MARK: - Base request
    
    private func performRequest(endPoint : String,
                                method : HTTPMethod,
                                params : [String : Any]? = nil,
                                headers : HTTPHeaders? = nil,
                                completion : @escaping ([String : Any]?, NSError?) -> Void) {
        
        
    }
    
    
    //MARK: - Authorization requests
    
    open func loginWith(login : String, password : String, completion : @escaping (Bool, String?) -> Void) {
        
    }

    open func signUpWith(login : String, email : String, password : String, confirm : String , inviterID : String?, completion : @escaping (Bool, String?) -> Void) {

    }

    open func signOut() {

    }
}
