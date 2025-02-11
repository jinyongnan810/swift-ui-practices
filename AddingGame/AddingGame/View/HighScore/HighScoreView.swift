//
//  HighScoreView.swift
//  AddingGame
//
//  Created by Yuunan kin on 2025/02/10.
//

import SwiftUI

struct HighScoreView: View {
    var body: some View {
        ZStack {
            HighScoreBackgroundView()
            VStack {
                HStack {
                    HighScoreTitleView(image: "creature0", text: "Rank")
                    HighScoreTitleView(image: "creature1", text: "Name")
                    HighScoreTitleView(image: "creature2", text: "Score")
                }
                HighScoreList()

                Spacer()
            }
        }
    }
}
