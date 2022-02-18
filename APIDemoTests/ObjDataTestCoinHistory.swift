//
//  ObjDataTestCoinHistory.swift
//  APIDemoTests
//
//  Created by Adam Beaumont on 18/02/2022.
//

import XCTest

class ObjDataTestCoinHistory: XCTestCase {
    var objCoin:ObjCoin!
    var objFakeCoin:ObjCoin!
    
    var objData:ObjData!
    
    override func setUpWithError() throws {
        objCoin = ObjCoin()
        objCoin.id = "bitcoin"
        
        objFakeCoin = ObjCoin()
        objFakeCoin.id = "bitcoin_tested"
        
        objData = ObjData()
    }
    
    override func tearDownWithError() throws {
        objCoin = nil
        objData = nil
    }
    
    // this tests that asking for a real coin gets you some data
    // because this is calling a real API it can fail with network issues
    func testObjDataGetCoinHistoryWithoutError(){
        let timeoutValue = TimeInterval(5)
        let expectation = XCTestExpectation(description: "Error getting data")
        objData.getCoinHistory(objCoin) { response, error in
            if error == nil{
                expectation.fulfill()
            }
        }
        let result: XCTWaiter.Result = XCTWaiter().wait(for: [expectation],  timeout: TimeInterval(timeoutValue))
        
        if result != .completed {
            XCTFail("We were able to get data for a fake coin \(objFakeCoin.id)")
        }
    }
    
    // this tests that asking for a fake coin gives you no data
    func testObjDataGetCoinHistoryWithError(){
        
        let timeoutValue = TimeInterval(5)
        let expectation = XCTestExpectation(description: "Error getting data")
        
        objData.getCoinHistory(objFakeCoin) { response, error in
            print("Response was \(response)")
            //      XCTAssertNotNil(error)
            if error != nil{
                print("There was an error \(error)")
                expectation.fulfill()
            }
        }
        
        let result: XCTWaiter.Result = XCTWaiter().wait(for: [expectation],  timeout: TimeInterval(timeoutValue))
        
        if result != .completed {
            XCTFail("We were able to get data for a fake coin \(objFakeCoin.id)")
        }
    }

}
