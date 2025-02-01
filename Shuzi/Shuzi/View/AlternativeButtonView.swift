//
//  AlternativeButtonView.swift
//  Shuzi
//
//  Created by Yuunan kin on 2025/02/01.
//

import SwiftUI

struct AlternativeButtonView: View {
    let number: Int
    let color: Color
    @Environment(GameViewModel.self) var viewModel
    var body: some View {
        let game = viewModel.game
        Button {
            viewModel.selectAnswer(number)
        } label: {
            Circle()
                .fill(color)
                .frame(width: 150, height: 150)
                .overlay {
                    Text(String(number))
                        .font(.title)
                        .foregroundStyle(.white)
                        .fontWeight(.semibold)
                }
                .shadow(radius: 5)
        }
    }
}

#Preview {
    AlternativeButtonView(number: 66, color: .blue)
}
