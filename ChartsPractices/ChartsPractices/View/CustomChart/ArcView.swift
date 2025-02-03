//
//  ArcView.swift
//  ChartsPractices
//
//  Created by Yuunan kin on 2025/02/03.
//

import SwiftUI

struct ArcView: View {
    let color: Color
    let startRadius: CGFloat
    let endRadius: CGFloat
    let startTrim: CGFloat
    let endTrim: CGFloat
    let rotate: Angle
    @State private var finalTrim: CGFloat = 0
    var lineWidth: CGFloat {
        endRadius - startRadius
    }

    var finalRadius: CGFloat {
        endRadius - lineWidth
    }

    var body: some View {
        Circle()
            .trim(from: startTrim, to: finalTrim)
            .stroke(color, style: .init(
                lineWidth: lineWidth,
                lineCap: .round
            ))
            .rotationEffect(rotate)
            .frame(width: finalRadius, height: finalRadius)
            .onAppear {
                withAnimation {
                    finalTrim = endTrim
                }
            }
    }
}

#Preview {
    ZStack {
        ArcView(
            color: .darkOrchid,
            startRadius: 90,
            endRadius: 100,
            startTrim: 0.25,
            endTrim: 0.75,
            rotate: Angle(degrees: 30)
        )
        Circle().stroke().frame(width: 100)
    }
}
