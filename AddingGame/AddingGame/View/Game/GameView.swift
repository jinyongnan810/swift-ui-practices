//
//  GameView.swift
//  AddingGame
//
//  Created by Yuunan kin on 2025/02/10.
//

import SwiftUI

struct GameView: View {
    @EnvironmentObject var viewModel: GameViewModel
    var body: some View {
        ZStack {
            GameBackgroundView()
            VStack {
                ScoreLivesView()
                Spacer()
                BubbleView(size: 200, text: "\(viewModel.num1) + \(viewModel.num2)", type: .bubble1)
                Spacer()
                OptionsView()
                Spacer()
            }
        }
    }
}

#Preview {
    GameView().environmentObject(GameViewModel())
}
