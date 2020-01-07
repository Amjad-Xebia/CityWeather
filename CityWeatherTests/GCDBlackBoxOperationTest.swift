//
//  GCDBlackBoxOperationTest.swift
//  CityWeatherTests
//
//  Created by Amjad Khan on 07/01/20.
//  Copyright © 2020 Xebia. All rights reserved.
//

import XCTest
@testable import CityWeather

class GCDBlackBoxOperationTest: XCTestCase {

    func testPerformingOperation() {
        
        var result: String?
        let expectation = self.expectation(description: #function)
        
        performUIUpdatesOnMain {
            result = "Hello World!"
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10)
        XCTAssertEqual(result, "Hello World!")
    }

}
