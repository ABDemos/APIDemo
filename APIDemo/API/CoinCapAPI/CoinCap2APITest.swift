//
//  CoinCapAPITest.swift
//  APIDemo
//
//  Created by Adam Beaumont on 18/02/2022.
//

import Foundation

// This is the test version of the API that returns static data for testing with
class CoinCap2APITest: CoinCap2API{
    
    // if required we can simulate network latency
    var bSimulateNetworkLatancy:Bool = false
    var networkLatency:TimeInterval = 0
    
    // get a list of all the coins from this API
    override func getCoins(completionHandler: @escaping APIResponse) {
        // call the completion handler immediately with dummy data
        completionHandler(createDummyCoinsData(), nil)
    }
    
    // get the history for a coin in the dummy data
    // get the coin history
    override func getCoinHistory(id:String, completionHandler: @escaping APIResponse) {
        
        // call the completion handler immediately with dummy data
        completionHandler(createDummyHistoryData(), nil)
        
    }
    
    // Here we are creating a test data set to use with the test API
    // we use the CoinCap2 data structures to create the data in code (although we could use test files)
    // Once created into the coins decodable we return it directly to the wrapper layer
    func createDummyCoinsData()->Decodable{
        
        var data = [Coin]()
        
        for i in 1 ... 20{
            let price = 40000+Double.random(in: (-1000 ... 1000))
            data.append(Coin(id: "bitcoin\(i)", rank: "1", symbol: "bitcoin\(i)", name: "Bitcoin-\(i)", supply: "1", maxSupply: "1", marketCapUsd: "1", volumeUsd24Hr: "1", priceUsd: "\(price)", changePercent24Hr: "0", vwap24Hr: "\(price)"))
        }
        
        let timestamp = Int(Date().timeIntervalSince1970*1000)
        let coins = Coins(data: data, timestamp: timestamp)
        
        return coins
    }
    
    // create a dummy price history
    func createDummyHistoryData()->Decodable{
        
        // todays timestamp
        let timestamp = Int(Date().timeIntervalSince1970*1000)
        
        var data = [Price]()
        
        // create a years worth of random price history
        var price:Double = 40000+Double.random(in: (-1000 ... 1000))
        for i in stride(from: 360, to: 1, by: -1){
            data.append(Price(priceUsd: "\(price)", time: timestamp - (i*24*60*60*1000)))
            price = price * Double.random(in: 0.8 ... 1.2)
        }
        
        let prices = Prices(data: data, timestamp: timestamp)
        
        return prices
        
        
    }
    
    
    
}
