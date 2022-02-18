//
//  API.swift
//  APIDemo
//
//  Created by Adam Beaumont on 18/02/2022.
//

import Foundation

// Base class for our low level API object
// This is the thing that actually calls the API, gets the data and parses it into something meaningful
// before passing it back up to the API wrapper

// This is our API Response format
typealias APIResponse = ((_ response: Any?, _ error: Error?) -> Void)

// Error handling
enum APIError: Error {
    case invalidRequest
    case invalidJSON
    case noInternet
    case unknown
}

// Base class for API
class API{
    
}

