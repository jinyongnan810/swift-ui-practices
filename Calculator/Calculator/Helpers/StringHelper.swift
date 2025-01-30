//
//  StringHelper.swift
//  Calculator
//
//  Created by Yuunan kin on 2025/01/29.
//
import Foundation

func getLastChar(str: String) -> String {
    str.isEmpty ? "" : String(str.last!)
}

func lastCharIsEqualTo(str: String, char: String) -> Bool {
    getLastChar(str: str) == char
}

func lastCharIsDigit(str: String) -> Bool {
    "0123456789".contains(getLastChar(str: str))
}

func lastCharIsDigitOrPercent(str: String) -> Bool {
    "0123456789%".contains(getLastChar(str: str))
}

func lastCharIsAnOperator(str: String) -> Bool {
    operators.contains(
        getLastChar(str: str)
    )
}

func formatResult(val: Double) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.maximumFractionDigits = 15
    return formatter.string(from: NSNumber(value: val)) ?? "NaN"
}
