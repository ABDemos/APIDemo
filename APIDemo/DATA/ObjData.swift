//
//  ObjData.swift
//  APIDemo
//
//  Created by Adam Beaumont on 18/02/2022.
//

import Foundation

// This is our one source of truth for data in this app
// It collects all our data from an API (which it doesn't have to know anything about)
// It then notifies the rest of the app when it has changed so that screens can subscribe to changes
// For example purposes we use two methods to tell the UI we have changed - (i) Notifications (ii) Callbacks

// this is how we will format callback
typealias DataResponse = ((_ response: Any?, _ error: Error?) -> Void)


// Main data object
class ObjData: ObservableObject{

    // ============================================================
    // Variables
    // ============================================================

    // Publically available data sets
    public var coins = [ObjCoin]()

    // This is the api that we are using - we can swap this out for another API if required
    let apiWrapper:APIWrapper = CoinCap2APIWrapper()

    // ============================================================
    // Constants
    // ============================================================

    // Notifications are defined here
    static let notificationDataError:String = "dataError"
    static let notificationDataRefresh:String = "dataRefresh"
    static let dataCoins:String = "coins"
    // ============================================================
    // Init
    // ============================================================

    // do initialisation
    init(){
        // get the list of coins as soon as we are created
        getCoins()
    }
    
    // ============================================================
    // Get Data
    // ============================================================

    // NOTIFICATION NOTIFICATION EXAMPLE
    // ask the api to get us some coins from the API
    func getCoins(){
        apiWrapper.getCoins { response, error in

            // if there is an error then we send out a notification
            if error != nil{
                let dict:[String:Any] = ["error": error as Any]
                
                let notify = Notification(name: Notification.Name(ObjData.notificationDataError), object: nil, userInfo: dict)
                NotificationCenter.default.post(notify)
                return
            }
            
            if let newCoins = response as? [ObjCoin]{
                self.coins = newCoins
                self.notifyChange(ObjData.dataCoins)
            }
        }
    }
    
    // CALLBACK NOTIFICATION EXAMPLE
    // Ask the api to get us some price history for this coin
    // we are going to use a callback to respond to the caller when we get our data for this call
    
    func getCoinHistory(_ thisCoin:ObjCoin, completionHandler: @escaping DataResponse){
        
        // ask the api to get price history for this coin
        apiWrapper.getCoinHistory(id: thisCoin.id, completionHandler: { response, error in
            if let coinHistory = response as? [ObjPrice]{
                // we have some data
                completionHandler(coinHistory, nil)
            }else{
                // there was a problem
                completionHandler(nil, error)
            }
        })
    }
    
    // ============================================================
    // Notification
    // ============================================================

    // broadcast that something has changed using the Notification center
    func notifyChange(_ label:String){
        
        let dict:[String:Any] = ["objects": [label]]
        let notify = Notification(name: Notification.Name(ObjData.notificationDataRefresh), object: nil, userInfo: dict)
        NotificationCenter.default.post(notify)
        
    }
    // ============================================================
    // ============================================================

}

