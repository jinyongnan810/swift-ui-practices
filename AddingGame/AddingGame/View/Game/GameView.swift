//
//  GameView.swift
//  AddingGame
//
//  Created by Yuunan kin on 2025/02/10.
//

import SwiftUI

struct GameView: View {
    @EnvironmentObject var viewModel: GameViewModel
    var gameOver: Bool {
        viewModel.gameOver
    }

    var body: some View {
        ZStack {
            GameBackgroundView()
            VStack {
                ScoreLivesView()
                Spacer()
                BubbleView(size: 200, text: "\(viewModel.num1) + \(viewModel.num2)", type: .bubble1)
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
                        viewModel.reset()
                    }
                }
        }
    }
}

#Preview {
    GameView().environmentObject(GameViewModel())
}
