//
//  CoinCap2APIWrapper.swift
//  APIDemo
//
//  Created by Adam Beaumont on 18/02/2022.
//


import Foundation


// this class provides an interface between our low level API and our app's data structures
// This is responsible for:
// - taking a request for the data object
// - getting data from the API
// - presenting the data back to the app data model

// If we need to keep the app but change how we get the data then we can replace this object without having to toucht the data object


class CoinCap2APIWrapper : APIWrapper{
    
    // This is the low level API that this wrapper supports
    var api:CoinCap2API!
    


    // choose the API we are going to use
    override func chooseAPI() {
        
        // if we are in DEBUG mode then we provide the option of using a dummy API
        #if DEBUG
        if UserDefaults.standard.bool(forKey: "TestApi"){
            api = CoinCap2APITest()
            return
        }
        #endif
        
        // otherwise choose the Live API
        api = CoinCap2APILive()
    }

    // ask the api to get a list of the top 100 coins
    override func getCoins(completionHandler: @escaping APIWrapperResponse){

        // call the low level api
        api.getCoins{ (jsonResponse: Any, error: Error?) in
            
            // There was an error so pass it back up
            if error != nil{
                DispatchQueue.main.async {
                    completionHandler(nil, error)
                }
                return
            }
            
            // parse the data into the Coins structure
            if let coins = jsonResponse as? Coins {
                
                // Data is in the correct format so now the wrapper needs to convert it into
                // data objects that the app's data model understands
                // This could be done automatically but there doesn't have to be a 1-1 mapping
                // between fields so we do it explicitly
                // The app data objects don't know anything about the API data and so we can't
                // have a constructor in the data object that takes API data
                
                var coinObjects = [ObjCoin]()
                
                // loop through the coins
                for coin in coins.data{
                    
                    let objCoin = ObjCoin()
                    objCoin.id = coin.id!
                    objCoin.name = coin.name!
                    objCoin.rank = coin.rank!
                    objCoin.symbol = coin.symbol!
                    objCoin.priceUsd = coin.priceUsd!
                    objCoin.marketCapUsd = coin.marketCapUsd!
                    objCoin.supply = coin.supply
                    objCoin.maxSupply = coin.maxSupply
                    objCoin.volumeUsd24Hr = coin.volumeUsd24Hr
                    objCoin.priceUsd = coin.priceUsd
                    objCoin.changePercent24Hr = coin.changePercent24Hr
                    objCoin.vwap24Hr = coin.vwap24Hr
                    
                    coinObjects.append(objCoin)
                }
                
                // we now have a list of coins that we can return to our app
                // Must do this on the main thread because it is going to hit the UI
                DispatchQueue.main.async {
                    completionHandler(coinObjects, nil)
                }

            }else{
                // for some reason we are unable to complete the data translation so send an error
                DispatchQueue.main.async {
                    completionHandler(nil, APIError.unknown)
                }
            }
        }
    }
    
    // we need to get some price history for a sepcific coin
    override func getCoinHistory(id:String, completionHandler: @escaping APIWrapperResponse){

        // call the lowe level API
        api.getCoinHistory(id: id) { response, error in

            // there was an error so pass it back up
            guard error == nil else{
                DispatchQueue.main.async {
                    completionHandler(nil, error)
                }
                return
            }
            
            // parse the data into a Prices structure
            if let prices = response as? Prices {

                // Data is in the correct format so now the wrapper needs to convert it into
                // data objects that the app's data model understands
                // This could be done automatically but there doesn't have to be a 1-1 mapping
                // between fields so we do it explicitly
                // The app data objects don't know anything about the API data and so we can't
                // have a constructor in the data object that takes API data

                var priceObjects = [ObjPrice]()
                
                for thisPrice in prices.data{
                    
                    // only add prices if they have all the data
                    if let priceString = thisPrice.priceUsd,
                       let price = Double(priceString),
                       let timestampSeconds = thisPrice.time
                    {
                        let p = ObjPrice()
                        p.price = price
                        p.timestamp = Double(timestampSeconds)
                        priceObjects.append(p)
                    }
                }
                
                // we now have a prices history that we can return to the UI
                DispatchQueue.main.async {
                    completionHandler(priceObjects, nil)
                }
            }else{
                // for some reason we are unable to complete the data translation so send an error
                DispatchQueue.main.async {
                    completionHandler(nil, APIError.unknown)
                }
            }
        }
    }
    
}
