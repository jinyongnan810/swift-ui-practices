//
//  ChocolateViewPractice.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2025/01/25.
//

import SwiftUI

struct ChocolateViewPractice: View {
    @State private var rotation: Angle = .zero

    var animation: Animation {
        .linear(duration: 0.4)
            .repeatForever(autoreverses: false)
    }

    var timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [.pink, .cyan],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            ).opacity(0.5)
            LinearGradient(
                colors: [.red, .blue],
                startPoint: .leading,
                endPoint: .trailing
            ).mask {
                GeometryReader { geometry in
                    Grid {
                        ForEach(0 ..< 40) { _ in
                            GridRow {
                                ForEach(0 ..< 20) { _ in
                                    Text("Chocolate").fixedSize()
                                }
                            }
                        }
                    }
                    .rotationEffect(rotation)
                    .animation(animation, value: rotation)
                    .onReceive(timer) { _ in
                        rotation += .degrees(5)
                    }
                    .frame(
                        width: geometry.size.width,
                        height: geometry.size.height
                    )
                    //                .frame(
                    //                    width: UIScreen.main.bounds.width,
                    //                    height: UIScreen.main.bounds.height
                    //                )
                }

            }

        }.ignoresSafeArea()
    }
}

#Preview {
    ChocolateViewPractice()
}
