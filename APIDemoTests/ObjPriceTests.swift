//
//  ObjPriceTests.swift
//  APIDemoTests
//
//  Created by Adam Beaumont on 18/02/2022.
//

import XCTest
@testable import APIDemo

class ObjPriceTests: XCTestCase {
    var objPrice:ObjPrice!
    
    override func setUpWithError() throws {
        objPrice = ObjPrice()
    }
    
    override func tearDownWithError() throws {
        objPrice = nil
    }
    
    func testObjPriceCheckForNils(){
        XCTAssertNotNil(objPrice.price )
        XCTAssertNotNil(objPrice.timestamp)
    }
    
    
    func testObjPriceDefaultProperties(){
        XCTAssert(objPrice.price == 0)
        XCTAssert(objPrice.timestamp == 0)
    }


}
