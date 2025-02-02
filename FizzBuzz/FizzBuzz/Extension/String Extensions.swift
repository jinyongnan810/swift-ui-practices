//
//  String Extensions.swift
//  FizzBuzz
//
//  Created by Yuunan kin on 2025/02/02.
//

import Foundation

extension String {
    func indent() -> String {
        var result = ""
        let lines = split(separator: "\n")
        for line in lines {
            result += "\t\(line)\n"
        }
        return String(result.dropLast())
    }
}
