//
//  ArcView.swift
//  Alarm
//
//  Created by Yuunan kin on 2025/02/18.
//

import SwiftUI

let width: CGFloat = 250
struct ArcView: View {
    @Binding var start: Date
    @Binding var end: Date
    var startPercent: CGFloat {
        start.percent()
    }

    var endPercent: CGFloat {
        end.percent()
    }

    var diff: CGFloat {
        if endPercent < startPercent {
            1 + endPercent - startPercent
        } else {
            endPercent - startPercent
        }
    }

    var rotation: Angle {
        Angle(degrees: 360 * startPercent - 90)
    }

    var body: some View {
        ZStack {
            Circle()
                .stroke(
                    .myLightGray,
                    style: .init(lineWidth: 15, lineCap: .round)
                )
                .overlay {
                    VStack(spacing: 4) {
                        Text("start")
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                        TimePickerView(time: $start)
                        Text("Duration").font(.title)
                        TimePickerView(time: $end)
                        Text("end").font(.subheadline)
                            .foregroundStyle(.gray)
                    }
                }
            Circle()
                .trim(from: 0, to: diff)
                .stroke(.myBlack, style: .init(lineWidth: 25, lineCap: .round))
                .rotationEffect(rotation)
            Circle()
                .trim(from: 0, to: diff)
                .stroke(.white, style: .init(lineWidth: 15, dash: [1, 2]))
                .rotationEffect(rotation)
            LineCapIcon(time: start)
            LineCapIcon(time: end)

        }.frame(width: width)
    }
}

struct LineCapIcon: View {
    let time: Date
    var percent: CGFloat {
        time.percent()
    }

    var body: some View {
        Circle()
            .fill(.white)
            .frame(width: 40, height: 40)
            .shadow(color: .myBlack.opacity(0.5), radius: 1, x: 0, y: 1)
            .overlay(
                TimeOfDayIcon(date: time)
            )
            .rotation3DEffect(.degrees(-percent * 360),
                              axis: (x: 0, y: 0, z: 1))
            .offset(y: -width / 2)
            .rotation3DEffect(.degrees(percent * 360),
                              axis: (x: 0, y: 0, z: 1))
    }
}

#Preview {
    ArcView(
        start: .constant(Date()),
        end: .constant(Date().addingTimeInterval(27200))
    )
}
