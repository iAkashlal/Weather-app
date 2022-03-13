//
//  WeatherDetailVC.swift
//  Weather
//
//  Created by akashlal on 13/03/22.
//

import UIKit
import SDWebImage

class WeatherDetailVC: UIViewController {
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var temperatureText: UILabel!
    @IBOutlet weak var feelsLikeText: UILabel!
    @IBOutlet weak var weatherTitle: UILabel!
    @IBOutlet weak var weatherSubtitle: UILabel!
    
    var viewModel = WeatherDetailVM()
    var coordinator: RootCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    func setLocation(with location: SearchResultModel) {
        self.viewModel.delegate = self
        self.viewModel.location = location
    }
    
}

extension WeatherDetailVC: WeatherDetailVMDelegate {
    func startLoading() {
        self.startSkeletonLoading()
    }
    
    func stopLoading() {
        self.stopSkeletonLoading()
    }
    
    func weatherLoaded() {
        guard let weather = viewModel.weatherData else { return }
        self.cityLabel.text = weather.name
        
        self.weatherIcon.sd_setImage(
            with: getImageFor(name: weather.weather?.first?.icon ?? "01d"),
            completed: nil)
//        self.weatherIcon.image = viewModel.weatherIcon
        self.weatherTitle.text = weather.weather?.first?.main
        self.weatherSubtitle.text = weather.weather?.first?.description
        guard let temperature = weather.main?.temp,
              let feelsLike = weather.main?.feelsLike else { return }
        self.temperatureText.text = String(describing: temperature) + " °C"
        self.feelsLikeText.text = "Feels like " + String(describing: feelsLike) + " °C"
        
    }
    
    private func getImageFor(name: String) -> URL {
        let urlString = "https://openweathermap.org/img/wn/*@2x.png"
            .replacingOccurrences(of: "*", with: name)
        return URL(string: urlString)!
    }
    
}

extension WeatherDetailVC: SkeletonLoading {
    var skeletableViews: [UIView] {
        return [
            cityLabel,
            weatherIcon,
            temperatureText,
            feelsLikeText,
            weatherTitle,
            weatherSubtitle
        ]
    }
    
    func updateSkeletonDesign(isEnding: Bool) {
        return
    }
    
    
}
