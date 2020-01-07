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
    @IBOutlet weak var tblWeather: UITableView!
    var dataArray: [Weather] = [Weather]()
    let loader = SmartDubaiLoader.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func fetchWeatherButtonPressed(_ sender: Any) {
        guard let city = self.txtCityName.text, !city.isEmpty else {
            showAlertMessage(title: "Error!", message: "Enter city name."); return
        }
        
        let cities = city.components(separatedBy: ",")
        if cities.count < 3 || cities.count > 7 {
            showAlertMessage(title: "Error!", message: "You can enter minimum 3 cities and max 7 cities")
        }
        else {
            // Make array empty
            dataArray.removeAll()
            txtCityName.text = String()
            txtCityName.resignFirstResponder()
            
            // Show loader
            loader.showActivityIndicator(uiView: self.view)
            
            // Fetch cities' wether
            for city in cities {
                NetworkManager().getCurrentWeather(cities: city) { [weak self] (weather, error) in
                    if let weather = weather {
                        self?.dataArray.append(weather)
                        if let cityCount = self?.dataArray.count, cityCount == cities.count {
                            performUIUpdatesOnMain {
                                self?.tblWeather.reloadData()
                                self?.loader.hideActivityIndicator()
                            }
                        }
                    }
                }
            }
        }
        
    }
    
    @IBAction func findCurrentCityAndWeatherButtonPressed(_ sender: Any) {
        // Show loader
        loader.showActivityIndicator(uiView: self.view)
        
        // Find current city name
        let locationManager = LocationManager.shared()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }
}

extension ViewController: LocationManagerDelegate {
    
    func findCurrentCityAndCountryName(city: String, country: String) {
        
        NetworkManager().getForecastWeather(city: city) { [weak self] (weathers, error) in
            guard let weathers = weathers else { return }
            self?.dataArray = weathers.list
            performUIUpdatesOnMain {
                self?.tblWeather.reloadData()
                self?.loader.hideActivityIndicator()
            }
        }
    }
    
    func fialedToFindCurrentCityNameWithError(error: Error) {
        print(error.localizedDescription)
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherTableViewCell", for: indexPath) as! WeatherTableViewCell
        cell.configureUI(weather: dataArray[indexPath.row])
        return cell
    }
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

