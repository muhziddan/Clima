//
//  ViewController.swift
//  Clima
//
//  Created by Muhammad Ziddan Hidayatullah on 19/05/22.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    var weatherManager = WeatherManager()
    var weatherModel: WeatherModel?
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        weatherManager.delegate = self
        searchTextField.delegate = self
    }
    
    func updateUI() {
        if let filledData = weatherModel {
            temperatureLabel.text = filledData.temperatureString
            cityLabel.text = filledData.cityName
            conditionImageView.image = UIImage(systemName: filledData.condition)
        }

        searchTextField.placeholder = "Search City"
    }
    
    
}

//MARK: - UITextFieldDelegate

extension WeatherViewController: UITextFieldDelegate {
    
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Type a City"
            return true
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        guard let cityText = searchTextField.text else {
            searchTextField.text = ""
            return
        }
        
        if cityText == "" {
            searchTextField.text = ""
            return
        }
        
        let trimmedText = cityText.trimmingCharacters(in: .whitespaces)
        
        weatherManager.fetchWeather(trimmedText)
        searchTextField.text = ""
    }
    
    
}

//MARK: - WeatherDataDelegate
extension WeatherViewController: WeatherDataDelegate {
    func didFailWithError(error: Error) {
        print(error)
    }
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.weatherModel = weather
            self.updateUI()
        }
    }
    
    
}

//MARK: - Location Manager Delegate

extension WeatherViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("called error")
        print(error)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print("called request")
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let currentLocation = locations.last else {return}
        
        let latitude = currentLocation.coordinate.latitude
        let longitude = currentLocation.coordinate.longitude
        
        weatherManager.fetchWeather(latitude: latitude, longitude: longitude)
    }
    
    
}
