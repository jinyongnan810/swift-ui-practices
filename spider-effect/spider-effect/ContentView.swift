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
    let centerDotRaidus: CGFloat = 10

    @State var dragPosition: CGPoint?
    let influence: CGFloat = 0.15

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

                guard let dragPosition else { return }

                // center dot
                let centerDot = CGRect(
                    x: dragPosition.x - centerDotRaidus,
                    y: dragPosition.y - centerDotRaidus,
                    width: centerDotRaidus * 2,
                    height: centerDotRaidus * 2
                )
                ctx.fill(Path(ellipseIn: centerDot), with: .color(.white))

                // dots and lines
                for dot in dots {
                    let dotCenter = CGPoint(
                        x: size.width * dot.x,
                        y: size.height * dot.y
                    )
                    let dotx = dotCenter.x - dotRadius
                    let doty = dotCenter.y - dotRadius
                    let distanceToCenter = hypot(
                        centerDot.origin.x - dotx,
                        centerDot.origin.y - doty
                    )

                    if influence < (distanceToCenter / size.height) {
                        continue
                    }

                    // dots
                    let rect = CGRect(
                        x: dotx,
                        y: doty,
                        width: dotRadius * 2,
                        height: dotRadius * 2
                    )
                    ctx.fill(Path(ellipseIn: rect), with: .color(.white))

                    // lines
                    var line = Path()
                    line.move(to: CGPoint(x: dragPosition.x, y: dragPosition.y))
                    line.addLine(to: dotCenter)
                    ctx.stroke(line, with: .color(.white))
                }
            }
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { value in
                        dragPosition = value.location
                    }
                    .onEnded { _ in
                        dragPosition = nil
                    }
            )
        }
    }
}

#Preview {
    ContentView()
}
