//
//  CoinCapAPILive.swift
//  APIDemo
//
//  Created by Adam Beaumont on 18/02/2022.
//

import Foundation

// Implement live data connection to the CoinCap2 API

// BASE API NAME
fileprivate let COINCAP2API_URL     = "https://api.coincap.io/v2/"

// Core API class to handle making calls to the API and decoding into specified formats
class CoinCap2APILive : CoinCap2API {
    

    // get a list of all the coins from this API
    override func getCoins(completionHandler: @escaping APIResponse) {
        
        // check the URL
        guard let requestUrl = URL(string: COINCAP2API_URL.appending("assets")) else {
            completionHandler(nil, APIError.invalidRequest)
            return
        }
        
        // Build request
        let request = NSMutableURLRequest(url: requestUrl, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 100)
        request.httpMethod = "GET"
        
        // Perform request
        perform(request: request as URLRequest, withType: Coins.self, completionHandler: completionHandler)
    }
    
    
    // get the coin history
    override func getCoinHistory(id:String, completionHandler: @escaping APIResponse) {
        
        // built a request with URL some query items specifying day interval
        var components = URLComponents(string: COINCAP2API_URL.appending("assets/\(id)/history"))
        components?.queryItems = [
            URLQueryItem(name: "interval", value: "d1")
        ]
        
        // check the request URL
        guard let requestUrl = components?.url else {
            completionHandler(nil, APIError.invalidRequest)
            return
        }
        // Build request
        let request = NSMutableURLRequest(url: requestUrl, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 100)
        
        request.httpMethod = "GET"
        
        // Perform request
        perform(request: request as URLRequest, withType: Prices.self, completionHandler: completionHandler)
    }
    
    
    // This is the handler to process the call to the api and handle a response
    // It parses the results of the API call into a decodable struct type passed as a parameter
    private func perform<T:Decodable>(request _request: URLRequest, withType:T.Type, completionHandler: @escaping APIResponse) {
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: _request) { (data: Data?, response: URLResponse?, error: Error?) in
            
            // check to see if the data actually exists
            guard let responseData = data else {
                
                if let e = error as NSError?, e.code == -1009{
                    // no internet connection
                    completionHandler(nil, APIError.noInternet)
                    return
                }
                completionHandler(nil, APIError.unknown)
                return
            }
            
            // now try to decode the data
            do{
                // SUCCESS
                let result = try JSONDecoder().decode(withType, from: responseData)
                completionHandler(result, nil)
                return
            }catch{
                // otherwise we are going to assume this is an invalid request
                completionHandler(nil, APIError.invalidRequest)
                return
            }
        }
        task.resume()
    }
    
    
}

