//
//  ObjDataTests.swift
//  APIDemoTests
//
//  Created by Adam Beaumont on 18/02/2022.
//

import XCTest

@testable import APIDemo

class ObjDataTests: XCTestCase {
    var objData:ObjData!
    
    override func setUpWithError() throws {
        objData = ObjData()
        
    }
    
    override func tearDownWithError() throws {
        objData = nil
    }
    
    
    // does this initialise correctly
    func testObjDataInitialisation(){
        XCTAssert(objData.coins.count == 0)
    }
    
    // do we get the dataRefresh notification back within 5 seconds
    // this is checking the end to end on the initial API call
    func testObjDataNotification(){
        let time:TimeInterval = 5
        let expectation = XCTNSNotificationExpectation(name: Notification.Name("dataRefresh"))
        
        let result: XCTWaiter.Result = XCTWaiter().wait(for: [expectation], timeout: time)
        
        if result != .completed {
            XCTFail("Data Refresh not observed within \(time) seconds")
        }
    }
}
