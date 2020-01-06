//
//  Weather.swift
//  CityWeather
//
//  Created by Amjad Khan on 06/01/20.
//  Copyright © 2020 Xebia. All rights reserved.
//

import Foundation

struct Weather: Codable {
    let tempMin: Float
    let tempMax: Float
    let humidity: Int
    let windSpeed: Float
    let weatherDesc: String
    
    enum CodingKeys: String, CodingKey {
        case name, main, wind, weather
    }
    
    enum MainCodingKeys: String, CodingKey {
        case temp_min, temp_max, humidity
    }
    
    enum WindCodingKeys: String, CodingKey {
        case speed
    }
    
    enum WeatherCodingKeys: String, CodingKey {
        case weatherDesc = "description"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let main = try container.nestedContainer(keyedBy: MainCodingKeys.self, forKey: .main)
        tempMin = try main.decode(Float.self, forKey: .temp_min)
        tempMax = try main.decode(Float.self, forKey: .temp_max)
        humidity = try main.decode(Int.self, forKey: .humidity)
        
        let wind = try container.nestedContainer(keyedBy: WindCodingKeys.self, forKey: .wind)
        windSpeed = try wind.decode(Float.self, forKey: .speed)
        
        var weather = try container.nestedUnkeyedContainer(forKey: .weather)
        var weatherArray = [String]()
        while !weather.isAtEnd {
            let weatherContainer = try weather.nestedContainer(keyedBy: WeatherCodingKeys.self)
            weatherArray.append(try weatherContainer.decode(String.self, forKey: .weatherDesc))
        }
        guard let firstWeatherDesc = weatherArray.first else {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: container.codingPath + [WeatherCodingKeys.weatherDesc], debugDescription: "description cannot be empty"))
        }
        weatherDesc = firstWeatherDesc
        
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        var main = container.nestedContainer(keyedBy: MainCodingKeys.self, forKey: .main)
        try main.encode(tempMin, forKey: .temp_min)
        try main.encode(tempMax, forKey: .temp_max)
        try main.encode(humidity, forKey: .humidity)
        
        var wind = container.nestedContainer(keyedBy: WindCodingKeys.self, forKey: .wind)
        try wind.encode(windSpeed, forKey: .speed)
    }
}
