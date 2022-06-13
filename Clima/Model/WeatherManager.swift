//
//  WeatherManager.swift
//  Clima
//
//  Created by Muhammad Ziddan Hidayatullah on 01/06/22.
//

import Foundation

struct WeatherManager {
    
    func fetchCity(_ cityName: String) {
        let url = "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=3beb2ead23c5bab59e6c5233f8cbf529&units=metric"
        request(url)
    }
    
    func request(_ urlInput: String) {
        guard let url = URL(string: urlInput) else {return}
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { data, response, error in
            if error != nil {
                print(error ?? "")
                return
            }
            
            guard let safeData = data else {return}
            
            let dataString = String(data: safeData, encoding: .utf8)
            print(dataString ?? "")
        }
        
        task.resume()// kenapa bahasanya resume? karena task ini sifatnya suspended/ditangguhkan same to pause, makanya method buat dimulainya namanya resume
    }
}