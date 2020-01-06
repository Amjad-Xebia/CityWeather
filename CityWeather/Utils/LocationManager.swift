//
//  LocationManager.swift
//  CityWeather
//
//  Created by Amjad Khan on 06/01/20.
//  Copyright © 2020 Xebia. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationManagerDelegate {
    func findCurrentCityAndCountryName(city: String, country: String)
    func fialedToFindCurrentCityNameWithError(error: Error)
}

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    var locationManager: CLLocationManager?
    var lastLocation: CLLocation?
    var placemark: CLPlacemark?
    var geocoder: CLGeocoder?
    var delegate: LocationManagerDelegate?
        
    private static let sharedlocationManager: LocationManager = {
        let networkManager = LocationManager()
        
        // Configuration
        // ...
        
        return networkManager
    }()
    
    private override init() {
        super.init()
        
        self.geocoder = CLGeocoder()
        self.locationManager = CLLocationManager()
        guard let locationManager = self.locationManager else {  return }
        
        if CLLocationManager.authorizationStatus() == .notDetermined {
            locationManager.requestAlwaysAuthorization()
        }
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 200
        locationManager.delegate = self
    }
    
    // MARK: - Accessors
    
    class func shared() -> LocationManager {
        return sharedlocationManager
    }
    
    func startUpdatingLocation() {
        self.locationManager?.startUpdatingLocation()
    }
    
    func stopUpdatingLocation() {
        self.locationManager?.stopUpdatingLocation()
    }
    
    // MARK:- CLLocationManagerDelegate
    
    internal func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        guard let location = locations.last else {
            return
        }
        
        // singleton for get last location
        self.lastLocation = location
        
        updateLocation(currentLocation: location)
    }
    
    internal func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        updateLocationDidFailWithError(error: error)
    }
    
    // MARK:- Private Functions
    
    private func updateLocation(currentLocation: CLLocation) {
        guard self.delegate != nil else {
            return
        }
        
        geocoder?.reverseGeocodeLocation(currentLocation, completionHandler: { (placemarks, error) in
            if error == nil, let placemark = placemarks, !placemark.isEmpty {
                self.placemark = placemark.last
            }
            self.parsePlacemarks()
        })
    }
    
    private func updateLocationDidFailWithError(error: Error) {
        
        guard let delegate = self.delegate else {
            return
        }
        delegate.fialedToFindCurrentCityNameWithError(error: error)
    }
    
    private func parsePlacemarks() {
        guard let delegate = self.delegate else { return }
        if let _ = lastLocation {
            if let placemark = placemark {
                if let city = placemark.locality, let country = placemark.country {
                    delegate.findCurrentCityAndCountryName(city: city, country: country)
                }
            }
        }
    }
    
}
