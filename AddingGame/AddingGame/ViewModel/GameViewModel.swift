//
//  GameViewModel.swift
//  AddingGame
//
//  Created by Yuunan kin on 2025/02/10.
//

import Foundation

class GameViewModel: ObservableObject {
    @Published var game: GameModel = .defaultGame

    private var problemCount = 0

    let nextLevelBound = 2

    var score: Int {
        game.score
    }

    var timeToGoToNextLevel: Bool {
        problemCount % nextLevelBound == 0
    }

    var gameOver: Bool {
        game.gameOver
    }

    var num1: Int {
        game.currentProblem.number1
    }

    var num2: Int {
        game.currentProblem.number2
    }

    var possibleSolutions: [Int] {
        game.currentProblem.possibleSolutions
    }

    func answer(_ answer: Int) {
        if game.currentProblem.check(answer) {
            game.score += min(game.level, 10)
        } else {
            game.lives -= 1
        }
        if !gameOver {
            nextProblem()
        }
    }

    func nextProblem() {
        problemCount += 1
        if timeToGoToNextLevel {
            game.level += 1
        }
        game.currentProblem = .init(level: game.level)
    }

    func reset() {
        game = GameModel.defaultGame
        problemCount = 0
    }
}
