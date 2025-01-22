//
//  ProgressBarPractice.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2025/01/22.
//

import SwiftUI

struct ProgressBarPractice: View {
    let width: CGFloat = 300
    let height: CGFloat = 40
    let cornerRadius: CGFloat = 20

    @State var progress: Double = 0
    var progressWidth: CGFloat {
        max(width * progress, cornerRadius)
    }
    var rightProgressBarCornerRadius: CGFloat {
        progressWidth > cornerRadius * 2 ? cornerRadius : (
            progressWidth - cornerRadius
        )
    }

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(.gray)
                .frame(width: width, height: height)
                .overlay(alignment: .leading) {
                        LinearGradient(
                            colors: [.blue, .red],
                            startPoint: .leading,
                            endPoint: .trailing
                        ).frame(width: progressWidth, height: height)
                        .clipShape(
                            .rect(
                                cornerRadii: .init(
                                    topLeading: cornerRadius,
                                    bottomLeading: cornerRadius,
                                    bottomTrailing: rightProgressBarCornerRadius,
                                    topTrailing: rightProgressBarCornerRadius
                                )
                            )
                        )
                }
            VStack {
                Spacer()
                Slider(value: $progress, in: 0...1)
                    .padding()
            }
        }
    }
}

#Preview {
    ProgressBarPractice()
}
