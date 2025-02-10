//
//  GameView.swift
//  AddingGame
//
//  Created by Yuunan kin on 2025/02/10.
//

import SwiftUI

struct GameView: View {
    var body: some View {
        ZStack {
            GameBackgroundView()
            VStack {
                ScoreLivesView()
                Spacer()
                BubbleView(size: 200, text: "77", type: .bubble1)
                Spacer()
            }
        }
    }
}

#Preview {
    GameView().environmentObject(GameViewModel())
}
