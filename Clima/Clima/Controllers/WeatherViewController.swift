//
//  WeatherViewController.swift
//  Clima
//
//  Created by Yuunan kin on 2024/12/07.
//

import UIKit

class WeatherViewController: UIViewController {
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var conditionImage: UIImageView!

    var weatherManager = WeatherManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        weatherManager.delegate = self

        searchTextField.delegate = self
        searchTextField.clearsOnBeginEditing = false
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    @IBAction func searchPressed(_: UIButton) {
        let text = searchTextField.text ?? ""
        search(text)
    }

    private func search(_ text: String) {
        searchTextField.endEditing(true)
        if text.isEmpty {
            return
        }
        weatherManager.fetch(text)
        searchTextField.text = ""
    }
}

extension WeatherViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text {
            search(text)
        }
        return true
    }
}

extension WeatherViewController: WeatherManagerDelegate {
    func onWeatherFetched(_ weather: Weather) {
        DispatchQueue.main.async {
            self.cityLabel.text = weather.city
            self.temperatureLabel.text = weather.temperatureString
            self.conditionImage.image = .init(systemName: weather.icon)
        }
    }

    func onFailed(_ error: any Error) {
        print("Fetch failed: \(error.localizedDescription)")
    }
}
