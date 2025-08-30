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
    let dotRadius: CGFloat = 2.5
    let centerDotRaidus: CGFloat = 5

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

                    let factor = distanceToCenter / size.height
                    let dim = max(0, min(1, influence / factor))
                    let dim2 = dim * dim

                    // dots
                    let rect = CGRect(
                        x: dotx,
                        y: doty,
                        width: dotRadius * 2 * dim2,
                        height: dotRadius * 2 * dim2
                    )
                    ctx
                        .fill(
                            Path(ellipseIn: rect),
                            with: .color(.yellow.opacity(dim2))
                        )

                    if influence < factor {
                        continue
                    }

                    // lines
                    var line = Path()
                    line.move(to: CGPoint(x: dragPosition.x, y: dragPosition.y))
                    let segements = Int.random(in: 4 ... 10)
                    let stepx = (dotCenter.x - dragPosition.x) / CGFloat(segements)
                    let stepy = (dotCenter.y - dragPosition.y) / CGFloat(segements)
                    for i in 1 ..< segements {
                        line
                            .addLine(
                                to: CGPoint(
                                    x: dragPosition.x + stepx *
                                        .random(in: 0.8 ... 1.2) * CGFloat(i),
                                    y: dragPosition.y + stepy *
                                        .random(in: 0.8 ... 1.2) * CGFloat(i),
                                )
                            )
                    }
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
