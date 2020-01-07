//
//  ForecastWeatherTest.swift
//  CityWeatherTests
//
//  Created by Amjad Khan on 07/01/20.
//  Copyright © 2020 Xebia. All rights reserved.
//

import XCTest
@testable import CityWeather

class ForecastWeatherModelTest: XCTestCase {

    var data: Data?
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        let json = """
            {
                "cod": "200",
                "list": [
                    {
                        "main": {
                            "temp_min": 288.4,
                            "temp_max": 289.58,
                            "humidity": 78,
                        },
                        "weather": [
                            {
                                "description": "light rain",
                            }
                        ],
                        "wind": {
                            "speed": 2.16,
                        },
                    },
                    {
                        "main": {
                            "temp_min": 287.3,
                            "temp_max": 288.18,
                            "humidity": 86,
                        },
                        "weather": [
                            {
                                "description": "light rain",
                            }
                        ],
                        "wind": {
                            "speed": 2.75,
                        }
                    }
                ]
            }
        """
        data = json.data(using: .utf8)
    }
    
    func testForecaseWeatherModel() {
        
        do {
            let weather = try JSONDecoder().decode(ForecastWeather.self, from: data!)
            XCTAssertNotNil(weather)
            XCTAssertEqual(weather.list.count, 2)
        } catch {
            print("Failed to decode JSON")
        }
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        data = nil
    }
}
