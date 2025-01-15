//
//  MeshGradientExample.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2025/01/14.
//

import SwiftUI

struct MeshGradientExample: View {
    @State var points: [SIMD2<Float>] = [
        [0, 0], [0.5, 0], [1, 0],
        [0, 0.5], [0.5, 0.5], [1, 0.5],
        [0, 1], [0.5, 1], [1, 1],
    ]

    @State var colors: [Color] = [
        .red, .blue, .green,
        .yellow, .orange, .purple,
        .cyan, .white, .black,
    ]

    var mesh: some View {
        MeshGradient(width: 3, height: 3, points: points, colors: colors)
    }

    var animation: Animation {
        .linear(duration: 5)
            .repeatForever(autoreverses: false)
    }

    var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        mesh
            .animation(animation, value: points)
            .ignoresSafeArea()
            .onReceive(timer) { _ in
                points[4].x = Float.random(in: 0 ... 1)
                points[4].y = Float.random(in: 0 ... 1)
            }
    }
}

#Preview {
    MeshGradientExample()
}
