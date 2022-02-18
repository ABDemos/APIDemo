//
//  Prices.swift
//  APIDemo
//
//  Created by Adam Beaumont on 18/02/2022.
//

import Foundation

// Data model for the price history call from the live Coin Cap API
// see // https://docs.coincap.io

struct Prices: Codable{
    var data:[Price]
    var timestamp:Int
    
    enum CodingKeys: String, CodingKey{
        case data
        case timestamp
    }
}

struct Price: Codable, Identifiable{
    var id:String {"\(time ?? 0)"}
    var priceUsd:String?
    var time:Int?
}
