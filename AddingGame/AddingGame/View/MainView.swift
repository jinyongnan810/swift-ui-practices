//
//  MainView.swift
//  AddingGame
//
//  Created by Yuunan kin on 2025/02/10.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var HIghScoreViewModel: HighScoreViewModel = .init()
    @ObservedObject var GameViewModel: GameViewModel = .init()
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
        }
    }
}

#Preview {
    MainView()
}
