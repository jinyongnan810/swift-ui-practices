//
//  ScoreLivesView.swift
//  AddingGame
//
//  Created by Yuunan kin on 2025/02/11.
//

import SwiftUI

struct ScoreLivesView: View {
    @EnvironmentObject var viewModel: GameViewModel
    var body: some View {
        HStack {
            TitleViewItem(
                title: "Score",
                value: viewModel.score
            )
            Spacer()
            TitleViewItem(title: "Level", value: viewModel.level)
            Spacer()
            LivesView(lives: viewModel.lives, maxLives: viewModel.game.maxLives)
        }.padding()
    }
}

struct TitleViewItem: View {
    let title: LocalizedStringKey
    let value: Int
    var body: some View {
        VStack {
            Text(title)
            Text("\(value)")
        }.font(.headline)
            .fontWeight(.bold)
            .foregroundStyle(.white)
    }
}

struct LivesView: View {
    let lives: Int
    let maxLives: Int
    var body: some View {
        HStack {
            ForEach(0 ..< maxLives, id: \.self) { i in
                Image("creature1")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .opacity(i >= lives ? 0 : 1)
            }
        }
    }
}
