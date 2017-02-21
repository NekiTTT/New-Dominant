//
//  Constants.swift
//  Dominant Investors
//
//  Created by Nekit on 19.02.17.
//  Copyright © 2017 Dominant. All rights reserved.
//

import UIKit

struct Values {
    static let DMTabsCount     : Int = 3
    static let DMDefaultScreen : Int = 0
}

struct Fonts {
    static let DMMyseoFont : UIFont = UIFont(name: "MuseoCyrl-100", size: 11)!
}

struct Backgrounds {
    
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
    
}


