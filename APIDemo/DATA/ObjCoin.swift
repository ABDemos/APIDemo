//
//  ObjCoin.swift
//  APIDemo
//
//  Created by Adam Beaumont on 18/02/2022.
//

import Foundation


// Class for crypto coin
// For this demo the class is very strongly linked to the underlying API data (but it doesn't have to be)
class ObjCoin{
    
    // ============================================================
    // Variables
    // ============================================================

    var id:String = ""
    var name:String = ""
    var symbol:String = ""
    var rank:String?
    var supply:String?
    var maxSupply:String?
    var marketCapUsd:String?
    var volumeUsd24Hr:String?
    var priceUsd:String?
    var changePercent24Hr:String?
    var vwap24Hr:String?
    
    
    // ============================================================
    // getter functions given that we have potentially null data for some fields
    // ============================================================
    
    // get a formatted 24 hour change
    public func getChange()->Double{
        if let change = changePercent24Hr{
            return Double(change) ?? 0
        }else{
            return 0
        }
    }
    
    // get the price (or zero if it doesn't exist)
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
    // ============================================================
    // ============================================================

}
