//
//  MainView.swift
//  AddingGame
//
//  Created by Yuunan kin on 2025/02/10.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var HIghScoreViewModel: HighScoreViewModel = .init()
    var body: some View {
        TabView {
            Tab("Game", systemImage:
                "gamecontroller") {}
            Tab("High Score", systemImage:
                "list.number") {}
        }
    }
}

#Preview {
    MainView()
}
