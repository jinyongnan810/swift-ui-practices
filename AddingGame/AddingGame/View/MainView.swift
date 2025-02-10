//
//  MainView.swift
//  AddingGame
//
//  Created by Yuunan kin on 2025/02/10.
//

import SwiftUI

struct MainView: View {
    @StateObject var highScoreViewModel: HighScoreViewModel = .init()
    @StateObject var gameViewModel: GameViewModel = .init()
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
        }.environmentObject(highScoreViewModel)
            .environmentObject(gameViewModel)
    }
}

#Preview {
    MainView()
}
