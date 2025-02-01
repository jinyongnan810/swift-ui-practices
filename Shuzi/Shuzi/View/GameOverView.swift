//
//  GameOverView.swift
//  Shuzi
//
//  Created by Yuunan kin on 2025/02/01.
//

import SwiftUI
struct GameOverView: View {
    @Environment(GameViewModel.self) var gameViewModel
    var body: some View {
        ZStack {
            Image(
                [.china1, .china2, .china3, .china4, .china5, .china6, .china7].randomElement() ?? .china1
            )
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()
            VStack {
                Text("Game Over")
                    .font(.largeTitle)
                    .padding()
                Text(
                    "Score: \(gameViewModel.game.score) out of \(gameViewModel.game.maxTurns)"
                )
                    .font(.headline)
                    .padding()

            }
            .padding()
            .background(
                Material.ultraThin,
                in: RoundedRectangle(cornerRadius: 10)
            )

        }.onTapGesture {
            gameViewModel.reset()
        }
    }
}

#Preview {
    GameOverView().environment(GameViewModel())
}
