//
//  DMSubscriptionViewController.swift
//  Dominant Investors
//
//  Created by Nekit on 19.02.17.
//  Copyright © 2017 Dominant. All rights reserved.
//

import UIKit
import Quickblox
import StoreKit

class DMSubscriptionViewController: DMViewController, SKProductsRequestDelegate {

    var expiredDate : NSDate! = nil
    var selectedProductIndex: Int!
    var transactionInProgress = false
    var products = [SKProduct]()
    var statusString = ""
    var delegate : DMContainerDelegate!
    
    @IBOutlet var backgroundImageView : UIImageView!
    @IBOutlet var overlayView : FXBlurView!
    
    var productIDs = [String]()
    
    var productsArray = [SKProduct]()
    
    //MARK: ViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.drawBlurView()
        self.backgroundImageView.image = self.backgroundImage()
        self.checkDate { (active) in
            if (active) {
                DispatchQueue.main.async {
                    self.showSignals()
                }
            } else {
                UserDefaults.standard.set(false, forKey: "kSignals")
            }
        }
        productIDs.append("dominantOne")
        self.requestProductInfo()
    }

    
    //MARK: Methods
    
    @IBAction func buy() {
        self.showActions()
    }
    
    @IBAction func restore() {
        
        if transactionInProgress {
            return
        } else {
            DispatchQueue.main.async {
                SKPaymentQueue.default().add(self as! SKPaymentTransactionObserver)
                SKPaymentQueue.default().restoreCompletedTransactions()
                self.transactionInProgress = true
            }
        }
    }
    
    @IBAction func closeAction() {
        self.dismiss(animated: false, completion: nil)
    }
    
    func drawBlurView() {
        self.overlayView.isBlurEnabled = true
        self.overlayView.blurRadius  = 20
        self.overlayView.isDynamic     = false
        self.overlayView.tintColor   = UIColor.lightGray
    }
    
    //MARK : SKProductsRequestDelegate
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        if response.products.count != 0 {
            for product in response.products {
                productsArray.append(product)
            }
        } else {
            print("There are no products.")
        }
    }
    
    
    func requestProductInfo() {
        if SKPaymentQueue.canMakePayments() {
            let productIdentifiers = NSSet(array: productIDs)
            let productRequest = SKProductsRequest(productIdentifiers: productIdentifiers as! Set<String>)
            
            productRequest.delegate = self
            productRequest.start()
        }
        else {
            print("Cannot perform In App Purchases.")
        }
    }
    
    func showActions() {
        
        if transactionInProgress {
            return
        }
        
        let actionSheetController = UIAlertController(title: "Dominant stock signals",
                                                      message: "Get investment signals subscription for one month?",
                                                      preferredStyle: UIAlertControllerStyle.alert)
        
        let buyAction = UIAlertAction(title: "Buy", style: UIAlertActionStyle.default) { (action) -> Void in
            DispatchQueue.main.async {
        
                if (self.productsArray.count > 0) {
                   
                    let payment = SKPayment(product: self.productsArray[0] as SKProduct)
                    SKPaymentQueue.default().add(self as! SKPaymentTransactionObserver)
                    SKPaymentQueue.default().add(payment)
                    self.transactionInProgress = true
                }
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
            
        }
        
        actionSheetController.addAction(buyAction)
        actionSheetController.addAction(cancelAction)
        
        present(actionSheetController, animated: true, completion: nil)
    }
    
    //MARK : SKPaymentTransactionObserver
    
    func paymentQueue(queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        
        for transaction in transactions {
            switch transaction.transactionState {
            case .purchased:
                
                print("Transaction completed successfully.")
                SKPaymentQueue.default().finishTransaction(transaction)
           
                DispatchQueue.main.async {
                    
                    if (transaction.transactionDate != nil) {
                        let cal = NSCalendar.current
                        let date = cal.date(byAdding: .month, value: 1, to: transaction.transactionDate!)
                        self.expiredDate = date as NSDate!
                        self.saveToQuickblox()
                        
                    }
                    self.transactionInProgress = false
                }
                
            case .failed:
                print("Transaction Failed");
                SKPaymentQueue.default().finishTransaction(transaction)
                self.transactionInProgress = false
                
            default:
                print(transaction.transactionState.rawValue)
            }
        }
    }
    
    func paymentQueueRestoreCompletedTransactionsFinished(queue: SKPaymentQueue) {
        print(queue)
        print(queue.transactions)
        
        if (queue.transactions.count == 0) {
            let alert = UIAlertController(title: "Error", message: "Nothing to restore", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil));
            
            self.present(alert, animated: true, completion: nil)
            self.transactionInProgress = false
            return
        }
        
        for transaction in queue.transactions {
            if (transaction.transactionIdentifier == "dominantOne") {
                let currentDateTime = NSDate()
                let cal = NSCalendar.current
                let date = cal.date(byAdding: .month, value: 1, to: transaction.transactionDate!)
                
                let expiredDate = date
                if (expiredDate!.compare(currentDateTime as Date) != .orderedAscending) {
                    self.expiredDate = date as NSDate!
                    self.saveToQuickblox()
                }
                self.transactionInProgress = false
            }
            
        }
    }
    
    
    //MARK : - To quickblox
    
    func saveToQuickblox() {
        
        let quickblox = QBCOCustomObject()
        quickblox.className = "SignalsBuyingDate"
        
        let name = UserDefaults().object(forKey: "kUsername") as! String
        quickblox.fields!.setObject(name, forKey:"name" as NSCopying)
        quickblox.fields!.setObject(self.expiredDate, forKey: "expiredDate" as NSCopying)
        quickblox.createdAt = self.expiredDate as Date?
        
        QBRequest.createObject(quickblox, successBlock: { (responce, object) in
            DispatchQueue.main.async {
                self.showSignals()
            }
        }) { (error) in
            
        }
    }
    
    var active : Bool!
    
    func checkDate(completion : @escaping (Bool) -> Void) {
        
        QBRequest.objects(withClassName: "SignalsBuyingDate", successBlock: { (responce, objects) in
            
            DispatchQueue.main.async {
        
                self.active = false
                
                for obj in objects! {
                    if let userDate = obj as? QBCOCustomObject {
                        let currentDateTime = NSDate()
                        if userDate.userID == QBSession.current().currentUser?.id {
                            
                            let cal = NSCalendar.current
                            let date = cal.date(byAdding: .month, value: 1, to: userDate.updatedAt!)
                            let expiredDate = date
                            if (expiredDate!.compare(currentDateTime as Date) != .orderedAscending) {
                                self.active = true
                                break
                            }
                        }
                    }
                }
                completion(self.active)
            }
            
        }) { (error) in
            
        }
    }
    
    func showSignals() {
        UserDefaults.standard.set(true, forKey: "kSignals")
        self.delegate.hideContainer()
    }
    
    func backgroundImage() -> UIImage {
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
