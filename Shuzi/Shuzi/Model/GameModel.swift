//
//  GameModel.swift
//  Shuzi
//
//  Created by Yuunan kin on 2025/01/31.
//

struct GameModel {
    var score: Int = 0
    var currentTurn: Int = 0
    var maxTurns: Int = 5
    var volume: Float = 0.5

    var answer: Int = 7
    var alternatives: [Int] = [5, 6, 7, 8]

    var gameCompleted: Bool {
        currentTurn >= maxTurns
    }

    mutating func incrementScore() {
        score += 1
    }

    mutating func incrementTurn() {
        currentTurn += 1
    }

    mutating func generateNewTurn() {
        alternatives = Array(0 ... 99).shuffled().prefix(4).map(\.self)
        answer = alternatives.first!
        alternatives.shuffle()
    }
}
