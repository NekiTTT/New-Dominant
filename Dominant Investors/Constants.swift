//
//  Constants.swift
//  Dominant Investors
//
//  Created by Nekit on 19.02.17.
//  Copyright © 2017 Dominant. All rights reserved.
//

import UIKit

enum DMPortfolioType : Int {
    case DMPersonalPortfolio = 0
    case DMDominantPortfolio = 1
}

enum DMActionType : Int {
    case DMAddNewStockAction = 0
    case DMClearPortfolioAction = 1
}

struct Values {
    static let DMTabsCount     : Int = 3
    static let DMDefaultScreen : Int = 0
    
}

struct Fonts {
    static let DMMyseoFont : UIFont = UIFont(name: "MuseoCyrl-100", size: 11)!
    static let DMMyseoUpperFont : UIFont = UIFont(name: "MuseoCyrl-100", size: 14)!
}

struct Colors {
    static let DMProfitGreenColor = UIColor.init(red: 84/255, green: 162/255, blue: 88/255, alpha: 1)
}

struct Strings {
    static let DMStandartLoginError  = NSLocalizedString("Wrong username or password.", comment: "")
    static let DMStandartSignUpError = NSLocalizedString("Account with provided username or e-mail already exist", comment: "")
}


