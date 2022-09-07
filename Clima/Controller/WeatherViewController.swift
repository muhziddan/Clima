//
//  ViewController.swift
//  Clima
//
//  Created by Muhammad Ziddan Hidayatullah on 19/05/22.
//

import UIKit

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    var weatherManager = WeatherManager()
    var weatherModel: WeatherModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        weatherManager.fetchCity(trimmedText)
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
