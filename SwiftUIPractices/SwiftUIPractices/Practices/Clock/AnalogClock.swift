//
//  AnalogClock.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2025/08/31.
//

import Foundation
import SwiftUI

struct AnalogClock: View {
    let centerDotRadius: CGFloat = 5

    var body: some View {
        TimelineView(.animation) { timeline in
            Canvas {
                ctx,
                    size in
                let clockRadius = Double(min(size.width, size.height) / 2)
                let calendar = Calendar.current
                var seconds = CGFloat(calendar.component(.second, from: timeline.date))
                let miliSeconds = calendar.component(
                    .nanosecond,
                    from: timeline.date
                ) / 1_000_000
                seconds = CGFloat(seconds) + CGFloat(miliSeconds) / 1000
                let minutes = calendar.component(.minute, from: timeline.date)
                let hours = calendar.component(.hour, from: timeline.date)

                // angles for each
                let secondsAngle = Double.pi * 2 / 60 * Double(seconds)
                let minutesAngle = Double.pi * 2 / 60 * Double(minutes)
                let hoursAngle = Double.pi * 2 / 12 * Double(hours)

                // center
                let center: CGPoint = .init(x: size.width / 2, y: size.height / 2)
                let centerDot = CGRect(
                    x: center.x - centerDotRadius,
                    y: center.y - centerDotRadius,
                    width: centerDotRadius * 2,
                    height: centerDotRadius * 2
                )
                ctx.fill(Path(ellipseIn: centerDot), with: .color(.primary))

                // hands
                let secondHandLength = clockRadius * 0.8
                let secondHandEnd: CGPoint = .init(
                    x: CGFloat(center.x + Foundation.sin(secondsAngle) * secondHandLength),
                    y: CGFloat(center.y - cos(secondsAngle) * secondHandLength)
                )
                var secondHandPath = Path()
                secondHandPath.move(to: center)
                secondHandPath.addLine(to: secondHandEnd)
                ctx
                    .stroke(
                        secondHandPath,
                        with: .color(.primary),
                        style: StrokeStyle(lineWidth: 2, lineCap: .round)
                    )
                let minuteHandLength = clockRadius * 0.6
                let minuteHandEnd: CGPoint = .init(
                    x: CGFloat(center.x + Foundation.sin(minutesAngle) * minuteHandLength),
                    y: CGFloat(center.y - Foundation.cos(minutesAngle) * minuteHandLength)
                )
                var minuteHandPath = Path()
                minuteHandPath.move(to: center)
                minuteHandPath.addLine(to: minuteHandEnd)
                ctx.stroke(minuteHandPath, with: .color(.primary), style: StrokeStyle(lineWidth: 5, lineCap: .round))
                let hourHandLength = clockRadius * 0.4
                let hourHandEnd: CGPoint = .init(
                    x: CGFloat(center.x + Foundation.sin(hoursAngle) * hourHandLength),
                    y: CGFloat(center.y - Foundation.cos(hoursAngle) * hourHandLength)
                )
                var hourHandPath = Path()
                hourHandPath.move(to: center)
                hourHandPath.addLine(to: hourHandEnd)
                ctx.stroke(hourHandPath, with: .color(.primary), style: StrokeStyle(lineWidth: 5, lineCap: .round))

                // Digits
                for i in 1 ... 12 {
                    let text = Text("\(i)").font(.headline).fontWeight(.bold)
                    let angle = Double.pi / 6 * Double(i)
//                    let textSize = ctx.resolve(text).measure(
//                        in: CGSize(width: 100, height: 100)
//                    )
                    let position: CGPoint = .init(
                        x: CGFloat(center.x + Foundation.sin(angle) * clockRadius * 0.85),
                        y: CGFloat(center.y - Foundation.cos(angle) * clockRadius * 0.85)
                    )
                    ctx.draw(text, at: position)
                }

                // Ticks
                for i in 1 ... 60 {
                    let longer = i.isMultiple(of: 5)
                    let outterPoint = CGPoint(
                        x: CGFloat(center.x + Foundation.sin(.pi / 30 * Double(i)) *
                            clockRadius * 0.99),
                        y: CGFloat(center.y - Foundation.cos(.pi / 30 * Double(i)) *
                            clockRadius * 0.99),
                    )
                    let innerPoint = CGPoint(
                        x: CGFloat(center.x + Foundation.sin(.pi / 30 * Double(i)) *
                            clockRadius * (longer ? 0.95 : 0.97)),
                        y: CGFloat(center.y - Foundation.cos(.pi / 30 * Double(i)) *
                            clockRadius * (longer ? 0.95 : 0.97)),
                    )
                    var tickPath = Path()
                    tickPath.move(to: outterPoint)
                    tickPath.addLine(to: innerPoint)
                    ctx.stroke(tickPath, with: .color(.secondary), style: StrokeStyle(lineWidth: 2, lineCap: .round))
                }

                // Outter Circle
//                let outterCirclePath = Path(
//                    ellipseIn: CGRect(
//                        origin: .init(
//                            x: center.x - clockRadius,
//                            y: center.y - clockRadius
//                        ),
//                        size: .init(width: clockRadius * 2, height: clockRadius * 2)
//                    )
//                )
//                ctx.stroke(outterCirclePath, with: .color(.secondary), style: StrokeStyle(lineWidth: 2, lineCap: .round))
            }
        }
    }
}

#Preview {
    AnalogClock()
}
