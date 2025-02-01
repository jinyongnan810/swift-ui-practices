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
    }
}

#Preview {
    ContentView()
        .environment(GameViewModel())
}
