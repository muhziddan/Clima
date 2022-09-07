//
//  WeatherManager.swift
//  Clima
//
//  Created by Muhammad Ziddan Hidayatullah on 01/06/22.
//

import Foundation

protocol WeatherDataDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    
    var delegate: WeatherDataDelegate?
    
    func fetchCity(_ cityName: String) {
        let url = "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=3beb2ead23c5bab59e6c5233f8cbf529&units=metric"
        request(url)
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
        
        task.resume()// kenapa bahasanya resume? karena task ini sifatnya suspended/ditangguhkan same to pause, makanya method buat dimulainya namanya resume
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
