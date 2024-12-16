//
//  BMI.swift
//  BMI Calculator
//
//  Created by Yuunan kin on 2024/12/07.
//
import UIKit

struct BMI {
    var value: Float
    var advice: String
    var color: UIColor

    func getBmiString() -> String {
        String(format: "%.1f", value)
    }
}
