//
//  ShapeExample.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2025/03/13.
//

import SwiftUI

struct ShapeExample: View {
    @State private var startAngle: CGFloat = 0
    @State private var waveHeight: CGFloat = 200
    @State private var waveOffset: CGFloat = 0
    let timer = Timer.publish(every: 0.01, on: .main, in: .common)
        .autoconnect()

    var body: some View {
        ZStack {
            Image("imgNature")
                .resizable()
                .frame(width: 400, height: 400)
                .clipShape(
                    StarShape(startAngle: startAngle)
                )

            VStack {
                Spacer()
                WaveShape()
                    .fill(
                        LinearGradient(
                            colors: [.green, .white],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .rotationEffect(.degrees(180))
                    .frame(height: waveHeight)
            }
        }
        .onReceive(timer) { _ in
            startAngle += 0.01
            waveHeight = sin(startAngle) * 40 + 200
            waveOffset += 0.01
            if waveOffset > 1 {
                waveOffset = 0
            }
        }
        .ignoresSafeArea()
    }
}

struct SqualCircleShape: Shape {
    func path(in rect: CGRect) -> Path {
        let radius: CGFloat = rect.width / 2
        return Path { path in
            path.move(to: .init(x: rect.minX, y: rect.minY))
            path.addLine(to: .init(x: rect.maxX, y: rect.minY))
            path.addLine(to: .init(x: rect.maxX, y: rect.maxY - radius))
            path
                .addArc(
                    center: .init(x: rect.midX, y: rect.maxY - radius),
                    radius: radius,
                    startAngle: .degrees(0),
                    endAngle: .degrees(180),
                    clockwise: false
                )
            path.addLine(to: .init(x: rect.minX, y: rect.minY))
        }
    }
}

struct StarShape: Shape {
    let startAngle: CGFloat
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let radius: CGFloat = rect.width / 2
        let halfRadius: CGFloat = radius / 2
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let pointsOnStar = 5
        let unitAngle = CGFloat.pi * 2 / CGFloat(pointsOnStar)

        let startPoint = center + .init(
            x: sin(startAngle) * radius,
            y: -cos(startAngle) * radius
        )
        path.move(to: startPoint)

        for i in 1 ... pointsOnStar {
            let angle: CGFloat = unitAngle * CGFloat(i) + startAngle
            let halfAngle = unitAngle * CGFloat(i) - unitAngle / 2 + startAngle

            let point1 = center + .init(
                x: sin(halfAngle) * halfRadius,
                y: -cos(halfAngle) * halfRadius
            )
            path.addLine(to: point1)

            let point2 = center + .init(
                x: sin(angle) * radius,
                y: -cos(angle) * radius
            )
            path.addLine(to: point2)
        }
        path.closeSubpath()
        return path
    }
}

struct WaveShape: Shape {
    var offset: CGFloat = 0
    func path(in rect: CGRect) -> Path {
        // TODO: implement wave
        var offset1 = 0.25 + offset
        offset1 = offset1 - CGFloat(Int(offset1))
        var offset2 = 0.75 + offset
        offset2 = offset2 - CGFloat(Int(offset2))
        let control1Offset: CGFloat = offset1 * rect.maxX
        let control2Offset: CGFloat = offset2 * rect.maxX
        return Path { path in
            path.move(to: CGPoint(x: 0, y: rect.midY))
            path
                .addCurve(
                    to: .init(x: rect.maxX, y: rect.midY),
                    control1: .init(
                        x: control1Offset,
                        y: 0
                    ),
                    control2: .init(x: control2Offset, y: rect.maxY)
                )
            path.addLine(to: .init(x: rect.maxX, y: 0))
            path.addLine(to: .init(x: 0, y: 0))
        }
    }
}

extension CGPoint {
    static func + (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
}

#Preview {
    ShapeExample()
}
