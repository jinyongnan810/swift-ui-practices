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

    let weatherManager = WeatherManager()

    override func viewDidLoad() {
        super.viewDidLoad()
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
