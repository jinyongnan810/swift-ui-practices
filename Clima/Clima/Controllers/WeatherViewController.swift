//
//  ViewController.swift
//  Clima
//
//  Created by Yuunan kin on 2024/12/07.
//

import UIKit

class WeatherViewController: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var conditionImage: UIImageView!
    
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

    @IBAction func searchPressed(_ sender: UIButton) {
        let text = searchTextField.text ?? ""
        search(text)
    }

    private func search(_ text: String) {
        searchTextField.endEditing(true)
        if text.isEmpty {
            return
        }
        print("\(text) searched.")
        searchTextField.text = ""
    }

}

extension WeatherViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text {
            self.search(text)
        }
        return true
    }
}
