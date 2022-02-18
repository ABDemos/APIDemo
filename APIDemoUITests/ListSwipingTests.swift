//
//  ListSwipingTests.swift
//  APIDemoUITests
//
//  Created by Adam Beaumont on 18/02/2022.
//

import XCTest

// test various list swiping
// NB These tests are relying on the live API to return data for them to work
//    This is obviously a point of potential failure and so must be monitored.
//    To solve this we need a dummy API running in the test environment to enable us to inject data into the testing process automatically and reliably

class ListSwipingTests: XCTestCase {
    
    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    override func tearDownWithError() throws {
    }
    
    // just check to see if we can swipe the list
    func testSwipeList() throws {
        let app = XCUIApplication()
        app.launchArguments.append("-TestApi")
        app.launchArguments.append("true")
        app.launch()
        
        let tablesQuery = XCUIApplication().tables
        
        XCTAssertGreaterThan(tablesQuery.cells.count, 0)
        
        guard let firstCell = tablesQuery.cells.allElementsBoundByIndex.first else { return }
        
        app.swipeUp()
        
        XCTAssertFalse(firstCell.isHittable)
        
    }
    
    // check to see if we can swipe to the last cell in the list
    func testSwipeListToEnd() throws {
        let app = XCUIApplication()
        app.launchArguments.append("-TestApi")
        app.launchArguments.append("true")
        app.launch()
        
        let tablesQuery = XCUIApplication().tables
        guard let lastCell = tablesQuery.cells.allElementsBoundByIndex.last else { return }
        let MAX_SCROLLS = 10
        var count = 0
        while lastCell.isHittable == false && count < MAX_SCROLLS {
            app.swipeUp()
            count += 1
        }
        
        XCTAssertTrue(lastCell.isHittable)
    }
    
}
