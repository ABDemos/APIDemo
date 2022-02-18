//
//  CoinCapAPI.swift
//  APIDemo
//
//  Created by Adam Beaumont on 18/02/2022.
//

import Foundation

// Default implementation of the CoinCap2API
// https://docs.coincap.io

class CoinCap2API : API{
    
    // get a list of coins from the API
    // expects a return in the form of a Coins object
    func getCoins(completionHandler: @escaping APIResponse){
        
    }
    
    // get the history for a given coin
    // expects a return in the form of a Prices object
    func getCoinHistory(id:String, completionHandler: @escaping APIResponse) {
        
    }
    
}
