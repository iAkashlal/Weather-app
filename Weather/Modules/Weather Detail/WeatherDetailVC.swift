//
//  WeatherDetailVC.swift
//  Weather
//
//  Created by akashlal on 13/03/22.
//

import UIKit

class WeatherDetailVC: UIViewController {
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var temperatureText: UILabel!
    @IBOutlet weak var feelsLikeText: UILabel!
    @IBOutlet weak var weatherTitle: UILabel!
    @IBOutlet weak var weatherSubtitle: UILabel!
    
    var viewModel = WeatherDetailVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func setLocation(with location: SearchResultModel) {
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
//        self.weatherIcon.image = viewModel.weatherIcon
        self.temperatureText.text = "\(weather.main?.temp)"
        self.feelsLikeText.text = "\(weather.main?.feelsLike)"
        self.weatherTitle.text = weather.weather?.first?.main
        self.weatherSubtitle.text = weather.weather?.first?.descriptionField
    }
    
}

extension WeatherDetailVC: SkeletonLoading {
    var skeletableViews: [UIView] {
        [
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