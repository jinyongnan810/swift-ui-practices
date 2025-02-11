//
//  OptionsView.swift
//  AddingGame
//
//  Created by Yuunan kin on 2025/02/11.
//

import SwiftUI

struct OptionsView: View {
    @EnvironmentObject var viewModel: GameViewModel
    let size = 100.0
    let spacing = 40.0
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    var body: some View {
        let options = viewModel.possibleSolutions
        LazyVGrid(columns: columns, spacing: spacing) {
            ForEach(0 ..< options.count, id: \.self) { index in
                let value = options[index]
                Button(action: {
                    withAnimation {
                        viewModel.answer(value)
                    }
                }) {
                    BubbleView(size: size, text: "\(value)", type: .bubble2)
                }
            }
        }
//        VStack(spacing: spacing) {
//            HStack(spacing: spacing) {
//                BubbleView(size: size, text: "\(options[0])", type: .bubble2)
//                BubbleView(size: size, text: "\(options[1])", type: .bubble2)
//            }
//            HStack(spacing: spacing) {
//                BubbleView(size: size, text: "\(options[2])", type: .bubble2)
//                BubbleView(size: size, text: "\(options[3])", type: .bubble2)
//            }
//        }
    }
}
