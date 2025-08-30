//
//  ContentView.swift
//  spider-effect
//
//  Created by Yuunan kin on 2025/08/30.
//

import SwiftUI

struct ContentView: View {
    var dots: [CGPoint]
    let dotCount = 100
    let dotRadius: CGFloat = 5
    init() {
        dots = (0 ..< dotCount).map { _ in
            CGPoint(x: CGFloat.random(in: 0 ... 1), y: CGFloat.random(in: 0 ... 1))
        }
    }

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            Canvas {
                ctx,
                    size in
                for dot in dots {
                    let rect = CGRect(
                        x: size.width * dot.x - dotRadius,
                        y: size.height * dot.y - dotRadius,
                        width: dotRadius * 2,
                        height: dotRadius * 2
                    )
                    ctx.fill(Path(ellipseIn: rect), with: .color(.white))
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
