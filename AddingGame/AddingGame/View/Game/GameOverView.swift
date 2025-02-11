//
//  GameOverView.swift
//  AddingGame
//
//  Created by Yuunan kin on 2025/02/11.
//

import SwiftUI

struct GameOverView: View {
    @Environment(
        HighScoreViewModel.self
    ) var highScoreViewModel: HighScoreViewModel
    @Environment(GameViewModel.self) var gameViewModel: GameViewModel
    var newHighScore: Bool {
        gameViewModel.score > highScoreViewModel.highestScore
    }

    var body: some View {
        VStack {
            Image("creature5")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
            Text("Game Over")
                .font(.largeTitle)
                .fontWeight(.bold)
            Text("Tap to restart")
                .font(.headline)
        }.foregroundStyle(.white)
    }
}
