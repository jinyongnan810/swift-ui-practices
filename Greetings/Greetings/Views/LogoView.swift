//
//  LogoView.swift
//  Greetings
//
//  Created by Yuunan kin on 2025/01/12.
//

import SwiftUI

struct LogoView: View {
    let lineWidth: CGFloat = 15.0
    let circleSize: CGFloat = 70.0
    @State private var isRotated: Bool = false
    var rotation: Angle {
        isRotated ? .zero : .degrees(360)
    }

    var angularGradient: AngularGradient {
        AngularGradient(gradient: Gradient(colors: [.orange, .pink, .purple, .blue, .green]), center: .center)
    }

    var body: some View {
        Circle()
            .strokeBorder(
                angularGradient,
                lineWidth: lineWidth
            )
            .rotationEffect(rotation)
            .frame(width: circleSize, height: circleSize)
            .onTapGesture {
                withAnimation(.spring()) {
                    isRotated.toggle()
                }
            }
    }
}

#Preview {
    LogoView()
}
