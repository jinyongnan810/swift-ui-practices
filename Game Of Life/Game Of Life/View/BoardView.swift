//
//  BoardView.swift
//  Game Of Life
//
//  Created by Yuunan kin on 2025/02/24.
//

import SwiftUI

struct BoardView: View {
    @Binding var board: BoardModel
    @Binding var designType: DesignType
    @Binding var swapXY: Bool

    var body: some View {
        GeometryReader { geo in
            let canvaseSize = min(geo.size.width, geo.size.height)
            let cellSize = canvaseSize / CGFloat(board.gridSize)
            ZStack {
                CanvasView(
                    creatures: $board.creatures,
                    gridSize: board.gridSize,
                    color: .blue
                )
                .onTapGesture { loc in
                    let row = Int(loc.y / cellSize)
                    let col = Int(loc.x / cellSize)
                    board
                        .applyDesignPattern(
                            row: row,
                            col: col,
                            type: designType,
                            swapXY: swapXY
                        )
                }
            }
            .border(.black, width: 3)
            .clipShape(.rect(cornerRadius: 5))
            .frame(width: canvaseSize, height: canvaseSize)
            .frame(maxHeight: .infinity)
        }
    }
}

struct CanvasView: View {
    @Binding var creatures: [[Int]]
    let gridSize: Int
    let color: Color
    var body: some View {
        Canvas {
            context,
                size in
            for row in 0 ..< gridSize {
                for col in 0 ..< gridSize {
                    let cellSize = size.width / CGFloat(gridSize)
                    let rect = CGRect(
                        x: CGFloat(col) * cellSize,
                        y: CGFloat(row) * cellSize,
                        width: cellSize,
                        height: cellSize
                    )
                    if creatures[row][col] == 1 {
                        context.fill(Path(rect), with: .color(color))
                    }
                }
            }
        }
    }
}

#Preview {
    @Previewable @State var creatures: [[Int]] = (0 ..< 25).map { _ in
        (0 ..< 25).map { _ in Int.random(in: 0 ... 1) }
    }
    CanvasView(creatures: $creatures, gridSize: 25, color: .blue)
        .padding()
}
