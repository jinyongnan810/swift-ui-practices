//
//  ContentView.swift
//  Shuzi
//
//  Created by Yuunan kin on 2025/01/31.
//

import SwiftUI

struct ContentView: View {
    @Environment(GameViewModel.self) var viewModel: GameViewModel
    @State private var showPinyin = false

    var body: some View {
        VStack {
            Text(
                "Score: \(viewModel.game.score) out of \(viewModel.game.maxTurns)"
            )
            .font(.largeTitle)
            Toggle("Show Pinyin", isOn: $showPinyin)
            Spacer()
            ShuziDisplayView(
                number: viewModel.game.answer,
                showPinyin: showPinyin
            )
            Spacer()
            AlternativeButtonsView()
        }
        .padding()
    }
}

#Preview {
    ContentView()
        .environment(GameViewModel())
}
