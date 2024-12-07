//
//  CalculatorBrain.swift
//  BMI Calculator
//
//  Created by Yuunan kin on 2024/12/07.
//
import UIKit

struct CalculatorBrain {
    var bmi: BMI? = nil

    mutating func calculate(_ height: Float, _ weight: Float) {
        let value = weight / pow(height, 2)
        let advice = switch value {
        case 0 ..< 18:
            "Eat more pies"
        case 18 ..< 24.9:
            "No advice for you"
        default:
            "Eat less pies"
        }
        let color: UIColor = switch value {
        case 0 ..< 18:
            .systemBlue
        case 18 ..< 24.9:
            .systemGreen
        default:
            .systemPink
        }
        bmi = BMI(value: value, advice: advice, color: color)
    }
}
