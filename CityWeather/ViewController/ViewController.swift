//
//  ViewController.swift
//  CityWeather
//
//  Created by Amjad Khan on 06/01/20.
//  Copyright © 2020 Xebia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        NetworkManager().getCurrentWeather(cities: "Delhi") { (weather, error) in
//            
//            if let weather = weather {
//                print(weather.cityName)
//                print(weather.tempMin)
//            }
//
//        }
        
        NetworkManager().getForecastWeather(city: "Delhi") { (weathers, error) in
            guard let weathers = weathers else { return }
            for weather in weathers.list {
                print(weather.weatherDesc)
            }
        }
    }


}

