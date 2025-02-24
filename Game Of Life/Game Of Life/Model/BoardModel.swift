//
//  BoardModel.swift
//  Game Of Life
//
//  Created by Yuunan kin on 2025/02/24.
//

import Foundation

struct BoardModel {
    var gridSize: Int
    var creatures: [[Int]] = []

    init(gridSize: Int) {
        self.gridSize = gridSize
        randomBoard()
    }

    mutating func randomBoard() {
        creatures = []
        for _ in 0 ..< gridSize {
            creatures
                .append(Array(repeating: Int.random(in: 0 ... 1), count: gridSize))
        }
    }

    mutating func claerBoard() {
        creatures = Array(repeating: Array(repeating: 0, count: gridSize), count: gridSize)
    }

    func countLiveNeighbors(x: Int, y: Int) -> Int {
        var count = 0
        for i in x - 1 ... x + 1 {
            for j in y - 1 ... y + 1 {
                if i >= 0, i < gridSize, j >= 0, j < gridSize, i != x, j != y {
                    count += creatures[i][j]
                }
            }
        }
        return count
    }

    mutating func updateCreature(x: Int, y: Int, state: Int) {
        creatures[x][y] = state
    }
}
