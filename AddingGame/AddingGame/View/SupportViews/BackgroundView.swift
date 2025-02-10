//
//  BackgroundView.swift
//  AddingGame
//
//  Created by Yuunan kin on 2025/02/10.
//

import SwiftUI

struct BackgroundView: View {
    let colorList: [Color]
    let opacity: Double
    var body: some View {
        LinearGradient(
            colors: colorList,
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        ).opacity(opacity)
            .ignoresSafeArea()
    }
}

struct GameBackgroundView: View {
    var body: some View {
        BackgroundView(colorList: [.purple, .blue, .clear], opacity: 0.7)
    }
}

struct HighScoreBackgroundView: View {
    var body: some View {
        BackgroundView(colorList: [.black, .gray, .clear], opacity: 0.7)
    }
}

#Preview {
    BackgroundView(colorList: [.red, .blue], opacity: 0.7)
}
