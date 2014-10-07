//
//  GarageTests.swift
//  GarageTests
//
//  Created by Muukii on 9/28/14.
//  Copyright (c) 2014 Muukii. All rights reserved.
//

import UIKit
import XCTest

class GarageTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCalculateFittingGridSize() {
        let size = Garage.CalculateFittingGridSize(maxWidth: 300, numberOfItemsInRow: 3, margin: 0, index: 0)
        let result = CGSizeMake(100, 100)
        XCTAssert(CGSizeEqualToSize(size, result), "")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            let width = Garage.CalculateFittingGridSize(maxWidth: 300, numberOfItemsInRow: 3, margin: 0, index: 0)
            // Put the code you want to measure the time of here.
        }
    }
    
}
