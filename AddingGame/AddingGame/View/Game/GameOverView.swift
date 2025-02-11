//
//  GameOverView.swift
//  AddingGame
//
//  Created by Yuunan kin on 2025/02/11.
//

import SwiftUI

struct GameOverView: View {
    @EnvironmentObject var gameViewModel: GameViewModel
    @EnvironmentObject var highScoreViewModel: HighScoreViewModel
    var newHighScore: Bool {
        gameViewModel.score > highScoreViewModel.highestScore
    }

    var body: some View {
        VStack {
            Image(newHighScore ? "creature2" : "creature5")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
            Text("Game Over")
                .font(.largeTitle)
                .fontWeight(.bold)
            Text(
                "Your score: \(gameViewModel.score)"
            ).font(.title)
                .fontWeight(.semibold)
            Text(
                "(Current High Score: \(highScoreViewModel.highestScore))"
            ).font(.title)
                .fontWeight(.semibold)
            Text("Tap to restart")
                .font(.headline)
        }.foregroundStyle(.white)
    }
}

#Preview {
    GameOverView()
}
