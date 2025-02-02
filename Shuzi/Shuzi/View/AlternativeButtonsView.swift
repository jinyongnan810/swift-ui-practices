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
        let alternatives = viewModel.game.alternatives

        Grid {
            GridRow {
                AlternativeButtonView(number: alternatives[0], color: .blue)
                AlternativeButtonView(number: alternatives[1], color: .red)
            }
            GridRow {
                AlternativeButtonView(number: alternatives[2], color: .green)
                AlternativeButtonView(number: alternatives[3], color: .purple)
            }
        }
    }
}

#Preview {
    AlternativeButtonsView()
}
