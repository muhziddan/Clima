//
//  WeatherData.swift
//  Clima
//
//  Created by Muhammad Ziddan Hidayatullah on 13/06/22.
//

import Foundation

struct WeatherData: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Decodable {
    let temp: Double
}

struct Weather: Decodable {
    let description: String
}
