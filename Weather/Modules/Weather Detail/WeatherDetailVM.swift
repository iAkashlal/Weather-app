//
//  WeatherDetailVM.swift
//  Weather
//
//  Created by akashlal on 13/03/22.
//

import Foundation

protocol WeatherDetailVMDelegate {
    func weatherLoaded()
}

class WeatherDetailVM {
    
    var delegate: WeatherDetailVMDelegate?
    
    var cityLabel: String?
    var weatherIcon: String?
    var temperatureText: String?
    var feelsLikeText: String?
    var weatherTitle: String?
    var weatherSubtitle: String?
    
    var location: SearchResultModel? {
        didSet {
            self.fetchWeather()
        }
    }
    
    func fetchWeather() {
        // API call to fetch weather
        
        // Once API fetches weather, call
//        self.delegate?.weatherLoaded()
    }
}
