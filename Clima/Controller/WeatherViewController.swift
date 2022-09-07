//
//  ViewController.swift
//  Clima
//
//  Created by Muhammad Ziddan Hidayatullah on 19/05/22.
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate {
    
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
        updateUI()
    }
    
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
        
        updateUI()
        searchTextField.text = ""
    }
    
    func updateUI() {
//        if let filledData = weatherModel {
//            print("called inside")
//            temperatureLabel.text = filledData.temperatureString
//            cityLabel.text = filledData.cityName
//        }

        searchTextField.placeholder = "Search City"

//        conditionImageView.image = UIImage(systemName: "")
    }
}

extension WeatherViewController: WeatherDataDelegate {
    
    func didUpdateWeather(weather: WeatherModel) {
        weatherModel = weather
        print(weatherModel)
    }
    
    
}
