//
//  GameView.swift
//  Game Of Life
//
//  Created by Yuunan kin on 2025/02/24.
//

// https://conwaylife.com

import SwiftUI

struct GameView: View {
    @State private var board: BoardModel = .init(gridSize: 25)
    var body: some View {
        ZStack {
            BackgroundView()
            VStack {
                TitleView()
                Spacer()
                BoardView(
                    creatures: $board.creatures,
                    gridSize: board.gridSize,
                    color: .blue
                )
                Spacer()
                ControlView()
            }
            .padding()
        }
    }
}

struct BackgroundView: View {
    var body: some View {
        Color.BG.opacity(0.6).ignoresSafeArea()
    }
}

struct TitleView: View {
    @Environment(\.colorScheme) var colorScheme

    var gradient: LinearGradient {
        switch colorScheme {
        case .light:
            LinearGradient(
                gradient: Gradient(colors: [.pink, .purple]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        default:
            LinearGradient(
                gradient: Gradient(colors: [.orange, .red]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        }
    }

    var shadowColor: Color {
        switch colorScheme {
        case .light:
            .black
        default:
            .white
        }
    }

    var body: some View {
        Text("Game of Life")
            .font(.largeTitle)
            .foregroundStyle(gradient)
            .shadow(color: shadowColor, radius: 2, x: 0, y: 2)
    }
}

#Preview {
    GameView()
}
