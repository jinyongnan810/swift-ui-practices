//
//  AlternativeButtonsView.swift
//  Shuzi
//
//  Created by Yuunan kin on 2025/02/01.
//

import SwiftUI

struct AlternativeButtonsView: View {
    @Environment(GameViewModel.self) var viewModel
    var body: some View {
        let game = viewModel.game
        Grid {
            GridRow {
                Button {} label: {
                    AlternativeButtonView(
                        text: String(game.alternatives[0]),
                        color: .blue
                    )
                }
                Button {} label: {
                    AlternativeButtonView(
                        text: String(game.alternatives[1]),
                        color: .red
                    )
                }
            }
            GridRow {
                Button {} label: {
                    AlternativeButtonView(
                        text: String(game.alternatives[2]),
                        color: .orange
                    )
                }
                Button {} label: {
                    AlternativeButtonView(
                        text: String(game.alternatives[3]),
                        color: .purple
                    )
                }
            }
        }
    }
}

#Preview {
    AlternativeButtonsView()
}
