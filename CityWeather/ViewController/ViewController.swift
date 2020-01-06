//
//  ViewController.swift
//  CityWeather
//
//  Created by Amjad Khan on 06/01/20.
//  Copyright © 2020 Xebia. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet weak var txtCityName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func fetchWeatherButtonPressed(_ sender: Any) {
        guard let city = self.txtCityName.text, !city.isEmpty else {
            print("Enter city name."); return
        }
        NetworkManager().getCurrentWeather(cities: city) { (weather, error) in
            if let weather = weather {
                print(weather.tempMin)
            }
        }
    }
    
    @IBAction func findCurrentCityAndWeatherButtonPressed(_ sender: Any) {
        let locationManager = LocationManager.shared()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }
}

extension ViewController: LocationManagerDelegate {
    
    func findCurrentCityAndCountryName(city: String, country: String) {
        
        NetworkManager().getForecastWeather(city: city) { (weathers, error) in
            guard let weathers = weathers else { return }
            for weather in weathers.list {
                print(weather.weatherDesc)
            }
        }
        
    }
    
    func fialedToFindCurrentCityNameWithError(error: Error) {
        print(error.localizedDescription)
    }
}

