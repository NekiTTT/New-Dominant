//
//  DMTrialModel.swift
//  Dominant Investors
//
//  Created by ios_nikitos on 29.11.17.
//  Copyright © 2017 Dominant. All rights reserved.
//

import UIKit

class DMTrialModel: NSObject {

    var id                : String?
    var name              : String?
    var trialBuyed        : Bool?
    var trialStarted      : Date?
    
    init(response : DMResponseObject) {
        super.init()
        
        self.id = response.id
        
        if let respName = response.fields["name"] as? String {
            self.name = respName
        }
        
        if let trialBuyedResp = response.fields["trialBuyed"] as? Bool {
            self.trialBuyed = trialBuyedResp
        }
        
        if let trialStartedResp = response.fields["trialStarted"] as? String {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            self.trialStarted = formatter.date(from: trialStartedResp)
        }
    
    }
}
