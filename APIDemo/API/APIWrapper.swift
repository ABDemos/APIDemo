//
//  APIWrapper.swift
//  APIDemo
//
//  Created by Adam Beaumont on 18/02/2022.
//

import Foundation

// The API Wrapper sits between the low-level API calls and the app data object
// It provides the bridge between the API data representation and the app data objects
//
// Having a wrapper means that we can:
//
// (i) Switch to a different API by changing the wrapper and the api
// (ii) Easily add a testing API with dummy data by just changing the low level API (see CoinCap2APITest)
//
// THe wrapper knows about both data representations and how to translate from API->App

// this is how this object is going to respond to requests
typealias APIWrapperResponse = ((_ response: Any?, _ error: Error?) -> Void)

// this is what an API Wrapper needs to provide
class APIWrapper{
    
    // When we are initialised we choose our API
    init(){
        chooseAPI()
    }
    
    func chooseAPI(){
        
    }

    // These are the functions that the App data object uses to get its data from whatever API is being used
    // They are expected to call the API, get the API data and convert to App data objects and then pass them
    // to the app data model
    
    func getCoins(completionHandler: @escaping APIWrapperResponse){
        
    }
    
    func getCoinHistory(id:String, completionHandler: @escaping APIWrapperResponse){
        
    }
}

