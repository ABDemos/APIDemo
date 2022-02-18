//
//  ObjCoinTests.swift
//  APIDemoTests
//
//  Created by Adam Beaumont on 18/02/2022.
//

import XCTest

@testable import APIDemo
class ObjCoinTests: XCTestCase {

    var objCoin:ObjCoin!

    override func setUpWithError() throws {
        objCoin = ObjCoin()
    }

    override func tearDownWithError() throws {
        objCoin = nil
    }

    // test that the coin object is initiated correctly
    func testNonNilProperties(){
        XCTAssertNotNil(objCoin.id)
        XCTAssertNotNil(objCoin.name)
        XCTAssertNotNil(objCoin.symbol)
    }
    
    // test that expected nil properties are nil
    func testNilProperties(){
        XCTAssertNil(objCoin.rank)
        XCTAssertNil(objCoin.supply)
        XCTAssertNil(objCoin.maxSupply)
        XCTAssertNil(objCoin.marketCapUsd)
        XCTAssertNil(objCoin.volumeUsd24Hr)
        XCTAssertNil(objCoin.priceUsd)
        XCTAssertNil(objCoin.changePercent24Hr)
        XCTAssertNil(objCoin.vwap24Hr)
    }
    
    // computed properties should return 0 if no underlying data
    func testComputedProperties(){
        XCTAssert(objCoin.getPrice() == 0)
        XCTAssert(objCoin.getVolume() == 0)
        XCTAssert(objCoin.getMarketCap() == 0)
        XCTAssert(objCoin.getMaxSupply() == 0)
        XCTAssert(objCoin.getSupply() == 0)
        XCTAssert(objCoin.getVWAP() == 0)
        XCTAssert(objCoin.getChange() == 0)
    }
    


}
