//
//  ObjCoinTestsWithTestData.swift
//  APIDemoTests
//
//  Created by Adam Beaumont on 18/02/2022.
//

import XCTest
@testable import APIDemo

class ObjCoinTestsWithTestData: XCTestCase {

    var objCoin:ObjCoin!
    
    // setup our dummy coin to test with
    override func setUpWithError() throws {
        objCoin = ObjCoin()
        objCoin.id = "bitcoin"
        objCoin.rank = "1"
        objCoin.symbol = "BTC"
        objCoin.priceUsd = "100"
        objCoin.supply = "123456"
        objCoin.maxSupply = "1234567"
        objCoin.marketCapUsd = "1234"
        objCoin.volumeUsd24Hr = "1235"
        objCoin.changePercent24Hr = "-0.25"
        objCoin.vwap24Hr = "54321"
        
    }
    
    // tear down
    override func tearDownWithError() throws {
        objCoin = nil
    }
    
    // check that the static values are what we would expect
    func testObjCoinCheckValues(){
        XCTAssert(objCoin.id == "bitcoin")
        XCTAssert(objCoin.rank == "1")
        XCTAssert(objCoin.symbol == "BTC")
        XCTAssert(objCoin.priceUsd == "100")
        XCTAssert(objCoin.supply == "123456")
        XCTAssert(objCoin.maxSupply == "1234567")
        XCTAssert(objCoin.marketCapUsd == "1234")
        XCTAssert(objCoin.volumeUsd24Hr == "1235")
        XCTAssert(objCoin.changePercent24Hr == "-0.25")
        XCTAssert(objCoin.vwap24Hr == "54321")
        
    }
    
    // check that the computed values in this case match expectations
    func testObjCoinComputedValues(){
        XCTAssert(objCoin.getPrice() == 100)
        XCTAssert(objCoin.getSupply() == 123456)
        XCTAssert(objCoin.getMaxSupply() == 1234567)
        XCTAssert(objCoin.getMarketCap() == 1234)
        XCTAssert(objCoin.getVolume() == 1235)
        XCTAssert(objCoin.getChange() == -0.25)
        XCTAssert(objCoin.getVWAP() == 54321)
        
    }

}
