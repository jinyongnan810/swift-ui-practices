//
//  MainView.swift
//  AddingGame
//
//  Created by Yuunan kin on 2025/02/10.
//

import SwiftData
import SwiftUI

struct MainView: View {
    @Environment(\.modelContext) private var context
    @State var highScoreViewModel: HighScoreViewModel
    @State var gameViewModel: GameViewModel = .init()

    init(
        context: ModelContext
    ) {
        _highScoreViewModel = State(
            initialValue: HighScoreViewModel(modelContext: context)
        )
    }

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
