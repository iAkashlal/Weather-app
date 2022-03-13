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
    func weatherLoaded() {
        self.cityLabel.text = viewModel.cityLabel
//        self.weatherIcon.image = viewModel.weatherIcon
        self.temperatureText.text = viewModel.temperatureText
        self.feelsLikeText.text = viewModel.feelsLikeText
        self.weatherTitle.text = viewModel.weatherTitle
        self.weatherSubtitle.text = viewModel.weatherSubtitle
    }
    
}
