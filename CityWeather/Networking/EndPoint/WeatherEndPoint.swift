//
//  WeatherEndPoint.swift
//  CityWeather
//
//  Created by Amjad Khan on 06/01/20.
//  Copyright © 2020 Xebia. All rights reserved.
//

import Foundation

enum NetworkEnvironment {
    case qa
    case production
    case staging
    case develop
}

public enum WeatherApi {
    case currentTemperatures(cities: String)
}

extension WeatherApi: EndPointType {
    
    var environmentBaseURL : String {
        switch NetworkManager.environment {
        case .production: return ""
        case .qa: return ""
        case .staging: return ""
        case .develop: return "http://api.openweathermap.org/data/2.5/"
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .currentTemperatures:
            return "weather"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        case .currentTemperatures(let query):
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: ["q": query,
                                                      "appid": NetworkManager.MovieAPIKey])
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}
