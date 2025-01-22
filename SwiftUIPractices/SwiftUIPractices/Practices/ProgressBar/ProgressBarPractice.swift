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
        width * progress
    }

    var progressHeight: CGFloat {
        if progressWidth < cornerRadius {
            let a = cornerRadius - progressWidth
            let b = cornerRadius
            return sqrt(b * b - a * a) * 2
        }
        return height
    }

    // not sure what to do with this
    var leftProgressBarCornerRadius: CGFloat {
        if progressWidth < cornerRadius {
            return progressHeight * 0.5
        }
        return cornerRadius
    }

    var rightProgressBarCornerRadius: CGFloat {
        progressWidth > cornerRadius * 2 ? cornerRadius : (
            progressWidth - cornerRadius
        )
    }

    var body: some View {
        ZStack {
            VStack {
                // MARK: - version 1

                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(.gray)
                    .frame(width: width, height: height)
                    .overlay(alignment: .leading) {
                        LinearGradient(
                            colors: [.blue, .red],
                            startPoint: .leading,
                            endPoint: .trailing
                        ).frame(width: progressWidth, height: progressHeight)
                            .clipShape(
                                .rect(
                                    cornerRadii: .init(
                                        topLeading: leftProgressBarCornerRadius,
                                        bottomLeading: leftProgressBarCornerRadius,
                                        bottomTrailing: rightProgressBarCornerRadius,
                                        topTrailing: rightProgressBarCornerRadius
                                    )
                                )
                            )
                    }
            }

            VStack {
                Spacer()
                Slider(value: $progress, in: 0 ... 1)
                    .padding()
            }
        }
    }
}

#Preview {
    ProgressBarPractice()
}
