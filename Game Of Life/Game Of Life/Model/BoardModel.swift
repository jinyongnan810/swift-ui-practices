//
//  BoardModel.swift
//  Game Of Life
//
//  Created by Yuunan kin on 2025/02/24.
//

import Foundation

let directions: [(x: Int, y: Int)] = [
    (-1, -1), (0, -1), (1, -1),
    (-1, 0), (1, 0),
    (-1, 1), (0, 1), (1, 1),
]
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

    func countLiveNeighbors(row: Int, col: Int) -> Int {
        var count = 0

        for direction in directions {
            let newRow = (row + direction.x + gridSize) % gridSize
            let newCol = (col + direction.y + gridSize) % gridSize
            count += creatures[newRow][newCol]
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

    mutating func nextGeneration() {
        var newCreatures = creatures
        for row in 0 ..< gridSize {
            for col in 0 ..< gridSize {
                let liveNeighbors = countLiveNeighbors(row: row, col: col)

                if creatures[row][col] == 1 { // current living
                    // dies from lonelyness or overcrowded
                    if liveNeighbors < 2 || liveNeighbors > 3 {
                        newCreatures[row][col] = 0
                    }
                } else { // current not living
                    // new born
                    if liveNeighbors == 3 {
                        newCreatures[row][col] = 1
                    }
                }
            }
        }
        creatures = newCreatures
    }
}
