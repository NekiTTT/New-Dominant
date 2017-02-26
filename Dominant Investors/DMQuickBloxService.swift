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
    
    // MARK: Get Data
    
    open func getPersonalPortfolio(completion : @escaping ([DMPersonalPortfolioModel]) -> Void) {
        QBRequest.objects(withClassName: "personal2", successBlock: { (response, objects) in
            var personal = [DMPersonalPortfolioModel]()
            for object in objects! {
                let model = DMPersonalPortfolioModel.init(response: DMResponseObject.init(customObject: object as! QBCOCustomObject))
                if (model.userID == DMAuthorizationManager.sharedInstance.userProfile.userID) {
                    personal.append(model)
                }
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
                dominant.append(DMDominantPortfolioModel.init(response:  DMResponseObject.init(customObject: object as! QBCOCustomObject)))
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
                ratings.append(DMRatingModel.init(response: DMResponseObject.init(customObject: object as! QBCOCustomObject)))
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
                companies.append(DMCompanyModel.init(response: DMResponseObject.init(customObject: object as! QBCOCustomObject)))
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
                signals.append(DMInvestmentSignalModel.init(response: DMResponseObject.init(customObject: object as! QBCOCustomObject)))
            }
            completion(signals)
        }) { (error) in
            completion([DMInvestmentSignalModel]())
        }
    }
    
    // MARK: Set Data
    
    open func addNew(personalStock : DMPersonalPortfolioModel, completion : @escaping ([DMPersonalPortfolioModel]) -> Void) {
        
        SwiftStockKit.fetchChartPoints(symbol: personalStock.ticker!, range: .OneDay) { (chartPoints) in
            
            let valuePrice = Double(chartPoints.last!.close!)
            let quickbloxStock = QBCOCustomObject()
            quickbloxStock.className = "personal2"
            quickbloxStock.fields!.setObject(personalStock.ticker!, forKey: "ticker" as NSCopying)
            quickbloxStock.fields!.setObject(DMDateService.sharedInstance.dominantStringFrom(date: Date()), forKey: "crt_at" as NSCopying)
            quickbloxStock.fields!.setObject(String(format: "%.2f", valuePrice), forKey: "entry_price" as NSCopying)
            
            QBRequest.createObject(quickbloxStock, successBlock: { (response, object) in
                if (object != nil) {
                    completion([DMPersonalPortfolioModel.init(response: DMResponseObject.init(customObject: object!))])
                }
            }) { (error) in
                print(error.error.debugDescription)
            }
        }
    }
    
    open func clearPortfolio(IDs : [String], completion : @escaping ([DMPersonalPortfolioModel]) -> Void) {
        QBRequest.deleteObjects(withIDs: IDs, className: "personal2", successBlock: { (response, array, array2, array3) in
            completion([DMPersonalPortfolioModel]())
        }) { (error) in
            completion([DMPersonalPortfolioModel]())
        }
    }
    
    open func deletePersonalStock(ID : String, completion : @escaping ([DMPersonalPortfolioModel]) -> Void) {
        QBRequest.deleteObject(withID: ID, className: "personal2", successBlock: { (response) in
            print(response)
        }) { (error) in
            print(error)
        }
    }
    
    open func loginWith(login : String, password : String, competion : @escaping (Bool, String?) -> Void) {
        QBRequest.logIn(withUserLogin: login, password: password, successBlock: { (response, user) in
            let userModel = DMUserProfileModel.init(response: DMResponseObject.init(user: user!))
            DMAuthorizationManager.sharedInstance.userProfile = userModel
            let data  = NSKeyedArchiver.archivedData(withRootObject: userModel)
            UserDefaults.standard.set(data, forKey : "Authorized")
            competion(true, nil)
        }) { (error) in
            competion(false, Strings.DMStandartLoginError)
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
            completion(false, Strings.DMStandartSignUpError)
        })
    }
    
    open func downloadCompanyImageWith(ID : String, completion : @escaping (UIImage, String) -> Void) {
        QBRequest.downloadFile(fromClassName: "Company", objectID: ID, fileFieldName: "companyPictureURLonQuickblox", successBlock: { (response, imageData) in
                    guard let data = imageData else { self.downloadCompanyImageWith(ID: ID, completion: completion)
                        return }
                    guard let image = UIImage(data : data) else { self.downloadCompanyImageWith(ID: ID, completion: completion)
                        return }
                    completion(image, ID)
        }, statusBlock: { (request, status) in
            
        }) { (errorResponse) in
                    self.downloadCompanyImageWith(ID: ID, completion: completion)
        }
    }
    
    open func downloadCompanyLogoWith(ID : String, completion : @escaping (UIImage) -> Void) {
    
        QBRequest.downloadFile(fromClassName: "Company", objectID: ID, fileFieldName: "companyLogoImage", successBlock: { (response, imageData) in
            guard let data   = imageData else { return }
            guard UIImage(data : data) != nil else { return }
            completion(UIImage(data : data)!)
        }, statusBlock: { (request, status) in
            
        }) { (errorResponse) in
            print(errorResponse.error.debugDescription)
        }
    }
    
    
    open func updateUserRating(value : Double) {
        DMAPIService.sharedInstance.getUserRatings { (ratings) in
            for rate in ratings {
                if (rate.userID == DMAuthorizationManager.sharedInstance.userProfile.userID
                || String(describing: QBSession.current().currentUser?.id) == rate.userID) {
                    self.updateExistRating(id: rate.id, value: value)
                    return
                }
            }
            self.recordUserRating(value: value)
        }
    }
    
    open func checkSubscription(completion : @escaping (DMSubscriptionModel?) -> Void) {
        QBRequest.objects(withClassName: "SignalsBuyingDate", successBlock: { (response, objects) in
            for obj in objects! {
                if let userDate = obj as? QBCOCustomObject {
                    if userDate.userID == QBSession.current().currentUser?.id {
                        let currentSubscription = DMSubscriptionModel.init(response: DMResponseObject(customObject: userDate))
                        completion(currentSubscription)
                        return
                    }
                }
            }
            completion(nil)
        }) { (error) in
            completion(nil)
        }
    }
    
    open func successPurchaseWith(expired_date : Date, completion : @escaping (Bool) -> Void) {
        self.checkSubscription { (subscription) in
            if (subscription != nil) {
                subscription?.expired_date = expired_date
                self.updateSubscription(subscription: subscription!, completion : completion)
            } else {
                self.recordNewSubscription(date : expired_date, completion : completion)
            }
        }
    }
    

    
    // MARK: Private
    
    private func updateSubscription(subscription : DMSubscriptionModel, completion : @escaping (Bool) -> Void) {
        
        let quickblox = QBCOCustomObject()
        quickblox.className = "SignalsBuyingDate"
        quickblox.fields!.setObject(subscription.expired_date, forKey: "expiredDate" as NSCopying)
        quickblox.id = subscription.id
        
        QBRequest.update(quickblox, successBlock: { (response, object) in
            completion(true)
        }) { (error) in
            completion(false)
        }
    }
    
    private func recordNewSubscription(date : Date, completion : @escaping (Bool) -> Void) {
        
        let quickblox = QBCOCustomObject()
        quickblox.className = "SignalsBuyingDate"
        quickblox.fields!.setObject(date, forKey: "expiredDate" as NSCopying)
        
        QBRequest.createObject(quickblox, successBlock: { (response, object) in
            completion(true)
        }) { (response) in
            completion(false)
        }
    }
    
    private func updateExistRating(id: String, value : Double) {
        let quickblox = QBCOCustomObject()
        
        quickblox.className = "userPortfolioTotal"
        quickblox.fields!.setObject(DMAuthorizationManager.sharedInstance.userProfile.userID, forKey: "userID" as NSCopying)
        quickblox.fields!.setObject(DMAuthorizationManager.sharedInstance.userProfile.userName, forKey:"userName" as NSCopying)
        quickblox.fields!.setObject("test@mail.com", forKey: "userMail" as NSCopying)
        quickblox.fields!.setObject(value, forKey: "portfolioTotalValue" as NSCopying)
        quickblox.id = id
        
        QBRequest.update(quickblox, successBlock: { (response, object) in
            print(response.description)
        }) { (error) in
            print(error.description)
        }
    }
    
    private func recordUserRating(value : Double) {
        
        let quickblox = QBCOCustomObject()
        quickblox.className = "userPortfolioTotal"
        
        quickblox.fields!.setObject(DMAuthorizationManager.sharedInstance.userProfile.userID, forKey: "userID" as NSCopying)
        quickblox.fields!.setObject(DMAuthorizationManager.sharedInstance.userProfile.userName, forKey:"userName" as NSCopying)
        quickblox.fields!.setObject("test@mail.com", forKey: "userMail" as NSCopying)
        quickblox.fields!.setObject(value, forKey: "portfolioTotalValue" as NSCopying)
        
        QBRequest.createObject(quickblox, successBlock: { (response, object) in
            print(response.description)
        }) { (response) in
            print(response.error?.error?.localizedDescription ?? "")
        }
    }
}
