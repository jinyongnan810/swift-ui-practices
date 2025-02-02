//
//  GameOverView.swift
//  Shuzi
//
//  Created by Yuunan kin on 2025/02/01.
//

import SwiftUI

let images: [ImageResource] = [.china1, .china2, .china3, .china4, .china5, .china6, .china7]
struct GameOverView: View {
    @Environment(GameViewModel.self) var gameViewModel
    @Environment(ProverbViewModel.self) var proverbViewModel
    @State var randomIndex: Int = .random(in: 0 ..< images.count)

    var body: some View {
        ZStack {
            Image(images[randomIndex])
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

                if let proverb = proverbViewModel.proverb {
                    VStack {
                        Text(proverb)
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text(proverbViewModel.translation ?? "")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                    }.padding()
                } else {
                    ProgressView()
                }
            }
            .padding()
            .background(
                Material.ultraThin,
                in: RoundedRectangle(cornerRadius: 10)
            )

        }.onTapGesture {
            gameViewModel.reset()
        }.onAppear {
            proverbViewModel.fetchProverb()
        }
    }
}

#Preview {
    GameOverView().environment(GameViewModel())
}
