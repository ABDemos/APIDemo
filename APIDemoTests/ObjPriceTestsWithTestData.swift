//
//  ObjPriceTestsWithTestData.swift
//  APIDemoTests
//
//  Created by Adam Beaumont on 18/02/2022.
//

import XCTest

@testable import APIDemo

class ObjPriceTestsWithTestData: XCTestCase {


    var objPrice:ObjPrice!
    
    override func setUpWithError() throws {
        objPrice = ObjPrice()
        objPrice.price = 100
        objPrice.timestamp = 123456789
    }
    
    override func tearDownWithError() throws {
        objPrice = nil
    }
    
    func testObjPriceTestDummyValues(){
        XCTAssert(objPrice.price == 100)
        XCTAssert(objPrice.timestamp == 123456789)
    }
}
