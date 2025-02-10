//
//  GameModel.swift
//  AddingGame
//
//  Created by Yuunan kin on 2025/02/10.
//

import Foundation

struct GameModel: Identifiable {
    let id: UUID = UUID()
    var level: Int
    var score: Int
    var speed: Int
    var lives: Int
    var currentProblem: ProblemModel

    var gameOver: Bool {
        lives <= 0
    }

    init(
        level: Int,
        score: Int,
        speed: Int,
        lives: Int
    ) {
        self.level = level
        self.score = score
        self.speed = speed
        self.lives = lives
        self.currentProblem = ProblemModel(level: level)
    }

    static let defaultGame: GameModel = .init(
        level: 1,
        score: 0,
        speed: 1,
        lives: 3
    )
}
