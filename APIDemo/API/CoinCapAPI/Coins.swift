//
//  Coins.swift
//  APIDemo
//
//  Created by Adam Beaumont on 18/02/2022.
//

import Foundation

// Data model for the data returned from the live Coin Cap API
// see // https://docs.coincap.io

struct Coins: Codable{
    var data:[Coin]
    var timestamp:Int
    
    enum CodingKeys: String, CodingKey{
        case data
        case timestamp
    }
}

struct Coin: Codable, Identifiable{
    var id:String?
    var rank:String?
    var symbol:String?
    var name:String?
    var supply:String?
    var maxSupply:String?
    var marketCapUsd:String?
    var volumeUsd24Hr:String?
    var priceUsd:String?
    var changePercent24Hr:String?
    var vwap24Hr:String?
    
    // helper function
    
    // get a formatted 24 hour change
    public func getChange()->Double{
        if let change = changePercent24Hr{
            return Double(change) ?? 0
        }else{
            return 0
        }
    }
    
    public func getPrice()->Double{
        if let price = priceUsd{
            return Double(price) ?? 0
        }else{
            return 0
        }
    }
    
    public func getSupply()->Double{
        return Double(supply ?? "0") ?? 0
    }
    public func getMaxSupply()->Double{
        return Double(maxSupply ?? "0") ?? 0
    }
    public func getMarketCap()->Double{
        return Double(marketCapUsd ?? "0") ?? 0
    }
    public func getVWAP()->Double{
        return Double(vwap24Hr ?? "0") ?? 0
    }
    public func getVolume()->Double{
        return Double(volumeUsd24Hr ?? "0") ?? 0
    }
    public func getFormattedPrice()->String{
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        let p = getPrice() as NSNumber
        if let s = formatter.string(from: p){
            return s
        }
        return "-"
    }
}

