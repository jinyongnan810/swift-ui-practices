//
//  TextWithGradientExample.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2025/01/18.
//

import SwiftUI

struct TextWithGradientExample: View {
    let colors: [Color] = [
        .brown,
        .black,
        .blue,
        .green,
        .yellow,
        .orange,
        .indigo,
        .purple,
        .red
    ]
    @State var randomColorIndex1: Int = 0
    @State var randomColorIndex2: Int = 1
    var body: some View {
        LinearGradient(
            colors: [colors[randomColorIndex1], colors[randomColorIndex2]],
            startPoint: .leading,
            endPoint: .trailing
        ).mask {
            Text("Text With Gradient")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
        }
        .onTapGesture {
            withAnimation {
                randomColorIndex1 = Int.random(in: 0..<colors.count)
                randomColorIndex2 = Int.random(in: 0..<colors.count)
            }
        }
    }
}

#Preview {
    TextWithGradientExample()
}
