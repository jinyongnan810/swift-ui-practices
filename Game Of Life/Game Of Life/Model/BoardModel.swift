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
        creatures = (0 ..< gridSize).map { _ in
            (0 ..< gridSize).map { _ in Int.random(in: 0 ... 1) }
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

    mutating func applyDesignPattern(row: Int, col: Int, type: DesignType, swapXY: Bool) {
        for design in type.offsetDesign {
            let dx = swapXY ? design.x : design.y
            let dy = swapXY ? design.y : design.x
            updateCreature(x: row + dx, y: col + dy, state: 1)
        }
    }
}
