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
        
        searchTextField.delegate = self
        weatherManager.delegate = self
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
        
        guard let cityText = textField.text else {return}
        
        if cityText == "" {return}
        
        weatherManager.fetchCity(cityText)
        
        guard let data = weatherModel else {return}
        print(data)
        
        updateUI()
        searchTextField.text = ""
    }
    
    func updateUI() {
        searchTextField.placeholder = "Search City"
        
//        conditionImageView.image = UIImage(systemName: "")
    }
}

extension WeatherViewController: WeatherDataDelegate {
    
    func didUpdateWeather(weather: WeatherModel) {
        weatherModel = weather
    }
    
    
}
