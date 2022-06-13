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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        updateUI()
        if textField.text != "" {
            return true
        } else {
            searchTextField.placeholder = "Type City"
            return true
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let cityText = textField.text else {
            return
        }
        
        weatherManager.fetchCity(cityText)
        searchTextField.text = ""
    }
    
    func updateUI() {
        searchTextField.placeholder = "Search City"
    }
}
