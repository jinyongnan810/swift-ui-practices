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
    let clockRadius: CGFloat = 200
    let secondHandLength: CGFloat = 150
    let minuteHandLength: CGFloat = 150
    let hourHandLength: CGFloat = 80

    var body: some View {
        TimelineView(.animation) { timeline in
            Canvas {
                ctx,
                    size in

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
                let secondsAngle: CGFloat = .init(Double.pi * 2 / 60) * CGFloat(seconds)
                let minutesAngle: CGFloat = .init(Double.pi * 2 / 60) * CGFloat(minutes)
                let hoursAngle: CGFloat = .init(Double.pi * 2 / 12) * CGFloat(hours)

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
                let secondHandEnd: CGPoint = .init(
                    x: center.x + Foundation.sin(secondsAngle) * secondHandLength,
                    y: center.y - Foundation.cos(secondsAngle) * secondHandLength
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
                let minuteHandEnd: CGPoint = .init(
                    x: center.x + Foundation.sin(minutesAngle) * minuteHandLength,
                    y: center.y - Foundation.cos(minutesAngle) * minuteHandLength
                )
                var minuteHandPath = Path()
                minuteHandPath.move(to: center)
                minuteHandPath.addLine(to: minuteHandEnd)
                ctx.stroke(minuteHandPath, with: .color(.primary), style: StrokeStyle(lineWidth: 5, lineCap: .round))
                let hourHandEnd: CGPoint = .init(
                    x: center.x + Foundation.sin(hoursAngle) * hourHandLength,
                    y: center.y - Foundation.cos(hoursAngle) * hourHandLength
                )
                var hourHandPath = Path()
                hourHandPath.move(to: center)
                hourHandPath.addLine(to: hourHandEnd)
                ctx.stroke(hourHandPath, with: .color(.primary), style: StrokeStyle(lineWidth: 5, lineCap: .round))
            }
        }
    }
}

#Preview {
    AnalogClock()
}
