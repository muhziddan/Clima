//
//  WeatherManager.swift
//  Clima
//
//  Created by Muhammad Ziddan Hidayatullah on 01/06/22.
//

import Foundation

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?q=jakarta&appid=3beb2ead23c5bab59e6c5233f8cbf529&units=metric"
    
    func fetchCity(_ cityName: String) {
        let url = "\(weatherURL)&q=\(cityName)"
        print(url)
    }
}
