//
//  TapItemTest.swift
//  APIDemoUITests
//
//  Created by Adam Beaumont on 18/02/2022.
//

import XCTest

class TapItemTest: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // press a button and move to the next screen
    func testTapItem() throws {
        let app = XCUIApplication()
        app.launchArguments.append("-TestApi")
        app.launchArguments.append("true")
        app.launch()
        
        let tablesQuery = XCUIApplication().tables
        
        XCTAssertGreaterThan(tablesQuery.cells.count, 0)
        
        guard let firstCell = tablesQuery.cells.allElementsBoundByIndex.first else { return }
        
        firstCell.tap()
        
        // if the cell has disappeared then we are on a new screen
        XCTAssertFalse(firstCell.isHittable)
        
    }
    
}
