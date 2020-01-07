//
//  WeatherTableViewCell.swift
//  CityWeather
//
//  Created by Amjad Khan on 07/01/20.
//  Copyright © 2020 Xebia. All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {

    @IBOutlet weak var lblCityName: UILabel!
    @IBOutlet weak var lblWindSpeed: UILabel!
    @IBOutlet weak var lblWeatherDesc: UILabel!
    @IBOutlet weak var lblMaxTemp: UILabel!
    @IBOutlet weak var lblMinTemp: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureUI(weather: Weather) {
        lblCityName.text = weather.cityName ?? ""
        lblMinTemp.text = "Min Temp: \(weather.tempMin)"
        lblMaxTemp.text = "Max Temp: \(weather.tempMax)"
        lblWeatherDesc.text = weather.weatherDesc
        lblWindSpeed.text = "Wind Speed: \(weather.windSpeed)"
    }

}
