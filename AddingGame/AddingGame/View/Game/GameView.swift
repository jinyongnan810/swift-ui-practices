//
//  GameView.swift
//  AddingGame
//
//  Created by Yuunan kin on 2025/02/10.
//

import SwiftUI

struct GameView: View {
    @Environment(
        HighScoreViewModel.self
    ) var highScoreViewModel: HighScoreViewModel
    @Environment(GameViewModel.self) var gameViewModel: GameViewModel
    @State private var showHighScoreView: Bool = false
    var gameOver: Bool {
        gameViewModel.gameOver
    }

    var newHighScore: Bool {
        gameOver && gameViewModel.score > highScoreViewModel.highestScore
    }

    var body: some View {
        ZStack {
            GameBackgroundView()
            VStack {
                ScoreLivesView()
                Spacer()
                BubbleView(size: 200, text: "\(gameViewModel.num1) + \(gameViewModel.num2)", type: .bubble1)
                Spacer()
                OptionsView()
                Spacer()
            }.blur(radius: gameOver ? 5 : 0)
                .disabled(gameOver)
            GameOverView()
                .opacity(gameOver ? 1 : 0)
                .blur(radius: gameOver ? 0 : 30)
                .disabled(!gameOver)
                .padding()
                .onTapGesture {
                    withAnimation {
                        gameViewModel.reset()
                    }
                }
        }
        .onChange(of: newHighScore) { _, newValue in
            if !newValue { return }
            withAnimation {
                showHighScoreView = true
            }
        }
        .fullScreenCover(
            isPresented: $showHighScoreView, onDismiss: {}, content: {
                NewHighScoreView(isPresented: $showHighScoreView)
            }
        )
    }
}
