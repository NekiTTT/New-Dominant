//
//  DMQuickBloxService.swift
//  Dominant Investors
//
//  Created by Nekit on 18.02.17.
//  Copyright © 2017 Dominant. All rights reserved.
//

import UIKit
import Quickblox

class DMQuickBloxService: NSObject {

    static let sharedInstance = DMQuickBloxService()
    
    // MARK : Get Data
    
    open func getPersonalPortfolio(completion : @escaping ([DMPersonalPortfolioModel]) -> Void) {
        QBRequest.objects(withClassName: "personal2", successBlock: { (response, objects) in
            var personal = [DMPersonalPortfolioModel]()
            for object in objects! {
                personal.append(DMPersonalPortfolioModel.init(response: object))
            }
            completion(personal)
        }) { (error) in
            completion([DMPersonalPortfolioModel]())
        }
    }
    
    open func getDominantPortfolio(completion : @escaping ([DMDominantPortfolioModel]) -> Void) {
        QBRequest.objects(withClassName: "dominantPortfolio", successBlock: { (response, objects) in
            var dominant = [DMDominantPortfolioModel]()
            for object in objects! {
                dominant.append(DMDominantPortfolioModel.init(response: object as! QBCOCustomObject))
            }
            completion(dominant)
        }) { (error) in
            completion([DMDominantPortfolioModel]())
        }
    }
    
    open func getUserRatings(completion : @escaping ([DMRatingModel]) -> Void) {
        QBRequest.objects(withClassName: "userPortfolioTotal", successBlock: { (response, objects) in
            var ratings = [DMRatingModel]()
            for object in objects! {
                ratings.append(DMRatingModel.init(response: object as! QBCOCustomObject))
            }
            completion(ratings)
        }) { (error) in
            completion([DMRatingModel]())
        }
    }
    
    open func getAnalyticsCompanies(completion : @escaping ([DMCompanyModel]) -> Void) {
        QBRequest.objects(withClassName: "Company", successBlock: { (response, objects) in
            var companies = [DMCompanyModel]()
            for object in objects! {
                companies.append(DMCompanyModel.init(response: object as! QBCOCustomObject))
            }
            completion(companies)
        }) { (error) in
            completion([DMCompanyModel]())
        }
    }
    
    open func getInvestmentSignals(completion : @escaping ([DMInvestmentSignalModel]) -> Void) {
        QBRequest.objects(withClassName: "InvestmentIdea", successBlock: { (response, objects) in
            var signals = [DMInvestmentSignalModel]()
            for object in objects! {
                signals.append(DMInvestmentSignalModel.init(response: object))
            }
            completion(signals)
        }) { (error) in
            completion([DMInvestmentSignalModel]())
        }
    }
    
    // MARK : Set Data
    
    open func addNew(personalStock : DMPersonalPortfolioModel, completion : ([DMPersonalPortfolioModel]) -> Void) {
    
        let personalStock = QBCOCustomObject()
        personalStock.className = "personal2"
        //quickblox.fields!.setObject(symbol, forKey: "ticker")
        
        QBRequest.createObject(personalStock, successBlock: { (response, object) in
            
        }) { (error) in
            
        }
    }
    
    open func clearPortfolio(IDs : [String], completion : @escaping ([DMPersonalPortfolioModel]) -> Void) {
        QBRequest.deleteObjects(withIDs: IDs, className: "personal2", successBlock: { (response, array, array2, array3) in
            completion([DMPersonalPortfolioModel]())
        }) { (error) in
            completion([DMPersonalPortfolioModel]())
        }
    }
    
    open func loginWith(login : String, password : String, competion : @escaping (Bool, String?) -> Void) {
        QBRequest.logIn(withUserLogin: login, password: password, successBlock: { (response, user) in
            let userModel = DMUserProfileModel.init(QBUser: user!)
            DMAuthorizationManager.sharedInstance.userProfile = userModel
            let data  = NSKeyedArchiver.archivedData(withRootObject: userModel)
            UserDefaults.standard.set(data, forKey : "Authorized")
            competion(true, nil)
        }) { (error) in
            competion(false, error.error.debugDescription)
        }
    }
    
    open func signUpWith(login : String, email : String, password : String, confirm : String , completion : @escaping (Bool, String?) -> Void) {
       
        let newUser = QBUUser()
        newUser.login = login
        newUser.password = password
        newUser.email = email
        
        QBRequest.signUp(newUser, successBlock: { (response, user) in
            completion(true, nil)
        }, errorBlock: { (responseError) in
            let reasons = responseError.error?.error?.localizedDescription
            completion(false, reasons)
        })
    }
    
    open func downloadCompanyImageWith(ID : String, completion : @escaping (UIImage) -> Void) {
        QBRequest.backgroundDownloadFile(fromClassName: "Company", objectID: ID, fileFieldName: "companyPictureURLonQuickblox", successBlock: { (response, imageData) in
            guard let data   = imageData else { return }
            guard UIImage(data : data) != nil else { return }
            completion(UIImage(data : data)!)
        }, statusBlock: { (request, status) in
            
        }) { (errorResponse) in
            print(errorResponse.error.debugDescription)
        }
    }
    
    open func downloadCompanyLogoWith(ID : String, completion : @escaping (UIImage) -> Void) {
        QBRequest.backgroundDownloadFile(fromClassName: "Company", objectID: ID, fileFieldName: "companyLogoImage", successBlock: { (response, imageData) in
            guard let data   = imageData else { return }
            guard UIImage(data : data) != nil else { return }
            completion(UIImage(data : data)!)
        }, statusBlock: { (request, status) in
            
        }) { (errorResponse) in
            print(errorResponse.error.debugDescription)
        }
    }
    
    
    open func updateUser(rating : DMRatingModel) {
        
    }
}
