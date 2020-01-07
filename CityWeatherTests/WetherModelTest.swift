//
//  WetherTest.swift
//  CityWeatherTests
//
//  Created by Amjad Khan on 07/01/20.
//  Copyright © 2020 Xebia. All rights reserved.
//

import XCTest
@testable import CityWeather

class WetherModelTest: XCTestCase {

    var data: Data?
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        let json = """
            {
                "name": "London",
                "weather": [
                    {
                        "description": "overcast clouds",
                    }
                ],
                "main": {
                    "temp_min": 282.59,
                    "temp_max": 285.15,
                    "humidity": 71
                },
                "wind": {
                    "speed": 4.6,
                }
            }
        """
        data = json.data(using: .utf8)
    }
    
    func testWeatherModel() {
        
        do {
            let weather = try JSONDecoder().decode(Weather.self, from: data!)
            XCTAssertNotNil(weather)
            XCTAssertEqual(weather.cityName, "London")
        } catch {
            print("Failed to decode JSON")
        }
    }
    
    func testWeatherModelEncoding() {
        
        let jsonString = """
            {
                "name": "London",
                "weather": [
                    {
                        "description": "overcast clouds",
                    }
                ],
                "main": {
                    "temp_min": 282.59,
                    "temp_max": 285.15,
                    "humidity": 71
                },
                "wind": {
                    "speed": 4.6,
                }
            }
        """
        
        do {
            let weather = try JSONDecoder().decode(Weather.self, from: data!)
            let encoded = try JSONEncoder().encode(weather)
            let output = String(data: encoded, encoding: .utf8)!
            XCTAssertNotEqual(jsonString, output)
        } catch {
            print("Failed to decode JSON")
        }
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        data = nil
    }


}

