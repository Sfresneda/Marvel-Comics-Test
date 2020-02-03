//
//  MarvelUITests.swift
//  MarvelUITests
//
//  Created by Sergio Fresneda on 1/30/20.
//  Copyright © 2020 Sergio Fresneda. All rights reserved.
//

import XCTest

class MarvelUITests: XCTestCase {

    override func setUp() {
        continueAfterFailure = false
    }

    override func tearDown() {}

    func testExample() {
        
        let app = XCUIApplication()
        app.launch()
        let comicsList = app.collectionViews["comics_collectionView"]
        
        let predicate = NSPredicate(format: "exists == true")
        let queryCell = comicsList.cells["cell_0"]
        
        expectation(for: predicate, evaluatedWith: queryCell, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssert(queryCell.exists)

    }
}
