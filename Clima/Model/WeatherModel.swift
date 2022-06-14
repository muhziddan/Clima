//
//  WeatherModel.swift
//  Clima
//
//  Created by Muhammad Ziddan Hidayatullah on 13/06/22.
//

import Foundation

struct WeatherModel {
    let weatherID: Int
    let cityName: String
    let temperature: Double
    
    var temperatureString: String {
        return String(round(temperature * 10) / 10)
    }
    
    var condition: String {
        switch weatherID {
        case 200...232:
            return "cloud.bolt.rain"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 700...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.sun"
        default:
            return "cloud"
        }
    }
}
