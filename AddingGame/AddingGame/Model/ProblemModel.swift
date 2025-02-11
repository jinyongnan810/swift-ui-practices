//
//  ProblemModel.swift
//  AddingGame
//
//  Created by Yuunan kin on 2025/02/10.
//

import Foundation

struct ProblemModel: Identifiable {
    let id: UUID = .init()
    let level: Int
    let number1: Int
    let number2: Int
    let possibleSolutions: [Int]
    let answer: Int

    func check(_ solution: Int) -> Bool {
        solution == answer
    }

    init(level: Int) {
        self.level = level
        let lowerBound: Int = (level - 1) * 10 + 1
        let upperBound: Int = level * 10
        number1 = Int.random(in: lowerBound ... upperBound)
        number2 = Int.random(in: lowerBound ... upperBound)
        answer = number1 + number2
        var fourRandomNumber: [Int] = []
        for _ in 0 ..< 3 {
            var randomNumber = Int.random(in: (lowerBound * 2) ... (upperBound * 2))
            while fourRandomNumber.contains(randomNumber) || randomNumber == answer {
                randomNumber = Int.random(in: (lowerBound * 2) ... (upperBound * 2))
            }
            fourRandomNumber.append(randomNumber)
        }
        fourRandomNumber.append(answer)
        possibleSolutions = fourRandomNumber.shuffled()
    }
}
