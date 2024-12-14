//
//  ResultViewController.swift
//  BMI Calculator
//
//  Created by Yuunan kin on 2024/12/07.
//

import UIKit

class ResultViewController: UIViewController {
    @IBOutlet var bmiLabel: UILabel!
    @IBOutlet var adviceLabel: UILabel!
    @IBAction func recalculatePressed(_: UIButton) {
        dismiss(animated: true)
    }

    var bmi: BMI?

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let bmi else {
            return
        }
        bmiLabel.text = bmi.getBmiString()
        adviceLabel.text = bmi.advice
        view.backgroundColor = bmi.color
    }
}
