//
//  ScoreView.swift
//  Shuzi
//
//  Created by Yuunan kin on 2025/02/01.
//

import SwiftUI

struct ScoreView: View {
    @Environment(GameViewModel.self) var viewModel
    var body: some View {
        Text(
            "Score: \(viewModel.game.score) out of \(viewModel.game.maxTurns)"
        )
        .font(.largeTitle)
    }
}

#Preview {
    ScoreView()
}
