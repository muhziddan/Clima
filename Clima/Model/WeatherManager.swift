//
//  WeatherManager.swift
//  Clima
//
//  Created by Muhammad Ziddan Hidayatullah on 01/06/22.
//

import Foundation
import CoreLocation

protocol WeatherDataDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    
    var delegate: WeatherDataDelegate?
    
    let baseURL = "https://api.openweathermap.org/data/2.5/weather?appid=3beb2ead23c5bab59e6c5233f8cbf529&units=metric"
    
    func fetchWeather(_ cityName: String) {
        let customURL = "\(baseURL)&q=\(cityName)"
        request(customURL)
    }
    
    func fetchWeather(latitude lat: CLLocationDegrees, longitude lon: CLLocationDegrees) {
        let customURL = "\(baseURL)&lat=\(lat)&lon=\(lon)"
        request(customURL)
    }
    
    func request(_ urlInput: String) {
        
        guard let url = URL(string: urlInput) else {return}
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { data, response, error in
            if error != nil {
                delegate?.didFailWithError(error: error!)
                return
            }
            
            guard let safeData = data else {return}
            
            guard let weatherData = parseJSON(safeData) else {return}
            
            delegate?.didUpdateWeather(self, weather: weatherData)
        }
        
        task.resume()
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let name = decodedData.name
            let temperature = decodedData.main.temp
            
            let weather = WeatherModel(weatherID: id, cityName: name, temperature: temperature)
            
            return weather
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
