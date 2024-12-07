//
//  CalculateViewController.swift
//  BMI Calculator
//
//  Created by Yuunan kin on 2024/12/04.
//

import UIKit

class CalculateViewController: UIViewController {
    @IBOutlet var heightSlider: UISlider!
    @IBOutlet var weightSlider: UISlider!
    @IBOutlet var heightLabel: UILabel!
    @IBOutlet var weightLabel: UILabel!

    var calculatorBrain = CalculatorBrain()

    @IBAction func heightChanged(_ sender: UISlider) {
        heightLabel.text = "\(String(format: "%.2f", sender.value))m"
    }

    @IBAction func weightChanged(_ sender: UISlider) {
        weightLabel.text = "\(String(format: "%.2f", sender.value))Kg"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func calculate(_: UIButton) {
        calculatorBrain.calculate(heightSlider.value, weightSlider.value)
        performSegue(withIdentifier: "goToResult", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender _: Any?) {
        if segue.identifier == "goToResult" {
            guard let bmi = calculatorBrain.bmi else {
                return
            }
            let viewController = segue.destination as! ResultViewController
            viewController.bmi = bmi
        }
    }
}
