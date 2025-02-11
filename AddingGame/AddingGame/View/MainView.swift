//
//  MainView.swift
//  AddingGame
//
//  Created by Yuunan kin on 2025/02/10.
//

import SwiftUI

struct MainView: View {
    @State var highScoreViewModel: HighScoreViewModel = .init()
    @State var gameViewModel: GameViewModel = .init()
    var body: some View {
        TabView {
            Tab("Game", systemImage:
                "gamecontroller")
            {
                GameView()
            }
            Tab("High Score", systemImage:
                "list.number")
            {
                HighScoreView()
            }
        }.environment(highScoreViewModel)
            .environment(gameViewModel)
    }
}

#Preview {
    MainView().environment(GameViewModel())
        .environment(HighScoreViewModel())
}
