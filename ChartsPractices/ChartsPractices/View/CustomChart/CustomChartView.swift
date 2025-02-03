//
//  CustomChartView.swift
//  ChartsPractices
//
//  Created by Yuunan kin on 2025/02/03.
//

import SwiftUI

struct CustomChartData: Identifiable {
    let id: UUID = .init()
    let number: Int
    let color: Color
}

let colors: [Color] = Color.randomColorsN(n: 7)
let data: [CustomChartData] = [
    .init(number: 100, color: colors[0]),
    .init(number: 30, color: colors[1]),
    .init(number: 50, color: colors[2]),
    .init(number: 70, color: colors[3]),
    .init(number: 90, color: colors[4]),
    .init(number: 120, color: colors[5]),
    .init(number: 40, color: colors[6]),
]
let max = 200

struct CustomChartView: View {
    @State private var tilt: CGFloat = 0
    var trims: [(start: CGFloat, end: CGFloat)] {
        let total = CGFloat(data.map(\.number).reduce(0, +))
        var result: [(start: CGFloat, end: CGFloat)] = []
        var start: CGFloat = 0
        for value in data.map(\.number) {
            let end: CGFloat = start + CGFloat(value) / total
            result.append((start: start, end: end))
            start = end
        }
        return result
    }

    var body: some View {
        GeometryReader { geo in
            Form {
                Section("Bar Chart") {
                    ZStack {
                        HStack(alignment: .bottom) {
                            ForEach(data, id: \.id) { item in
                                CustomChartBar(
                                    value: item.number,
                                    color: item.color,
                                    width: geo.size.width / CGFloat(data.count) * 0.7
                                )
                            }
                        }
                        .scaleEffect(x: tilt == 0 ? 1 : 0.7, y: 1)
                        .rotation3DEffect(.degrees(tilt * 45), axis: (x: 0, y: 1, z: 0))
                        .gesture(DragGesture().onChanged { value in
                            withAnimation {
                                if value.translation.width > 100 {
                                    tilt = 1
                                } else if value.translation.width < -100 {
                                    tilt = -1
                                } else {
                                    tilt = 0
                                }
                            }

                        }).onTapGesture {
                            withAnimation {
                                tilt = 0
                            }
                        }
                    }
                }
                Section("Arc Chart") {
                    ZStack {
                        ForEach(
                            Array(data.enumerated()),
                            id: \.element.id
                        ) { index, item in
                            ArcView(
                                color: item.color,
                                startRadius: 180,
                                endRadius: 200,
                                startTrim: trims[index].start,
                                endTrim: trims[index].end,
                                rotate: .zero
                            )
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    CustomChartView()
}
