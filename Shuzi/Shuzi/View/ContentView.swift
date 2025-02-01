//
//  ContentView.swift
//  Shuzi
//
//  Created by Yuunan kin on 2025/01/31.
//

import SwiftUI

struct ContentView: View {
    @Environment(GameViewModel.self) var viewModel: GameViewModel
    @State private var showSettings = false
    @State private var showGameOver = false
    private var gameOver: Bool {
        viewModel.game.currentTurn >= viewModel.game.maxTurns
    }

    var body: some View {
        
        ZStack {
            GearButtonView(showSettings: $showSettings)
            VStack {
                ScoreView()
                Spacer()
                ShuziDisplayView(
                    number: viewModel.game.answer,
                    showPinyin:
                        viewModel.game.showPinyin
                )
                Spacer()
                AlternativeButtonsView()
            }
            .padding()
            Text("showSettings: \(showSettings)")
        }.sheet(isPresented: $showSettings) {
            SettingsView()
        }
        .fullScreenCover(isPresented: $showGameOver) {
            GameOverView()
        }
        .onChange(of: gameOver) { oldValue, newValue in
            withAnimation {
                showGameOver = newValue
            }
        }
    }
}

#Preview {
    ContentView()
        .environment(GameViewModel())
}
