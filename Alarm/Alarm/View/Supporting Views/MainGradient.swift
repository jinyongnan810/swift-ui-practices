//
//  MainGradient.swift
//  Alarm
//
//  Created by Yuunan kin on 2025/02/15.
//

import SwiftUI

struct MainGradient: View {
    var startRadius: CGFloat = 0
    let endRadius: CGFloat
    var scale: CGFloat = 2
    var opacityForLinearGradient: Double = 0.5
    var opacityForRadialGradient: Double = 1

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [.myBlue, .myPurple, .myPink],
                startPoint: .top,
                endPoint: .bottom
            ).opacity(opacityForLinearGradient)
            RadialGradient(
                colors: [.myYellow, .clear],
                center: .bottom,
                startRadius: startRadius,
                endRadius: endRadius
            ).opacity(opacityForRadialGradient)
                .scaleEffect(x: scale)
        }
    }
}

#Preview {
    MainGradient(endRadius: 70)
}
