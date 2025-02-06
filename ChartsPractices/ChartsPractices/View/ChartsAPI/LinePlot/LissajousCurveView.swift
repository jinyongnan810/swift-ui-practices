//
//  LissajousCurveView.swift
//  ChartsPractices
//
//  Created by Yuunan kin on 2025/02/06.
//

import Charts
import SwiftUI

// https://en.wikipedia.org/wiki/Lissajous_curve
struct LissajousCurveView: View {
    let A = 3.0
    let B = 3.0
    @State var a = 1.0
    @State var b = 2.0
    let sigma = Double.pi / 2

    var body: some View {
        VStack {
            Chart { [a, b] in
                LinePlot(x: "x", y: "y", t: "t", domain: 0 ... .pi * 2) { t in
                    let x = A * sin(a * t + sigma)
                    let y = B * sin(b * t)
                    return (x, y)
                }
            }.padding()
                .chartXScale(domain: -5 ... 5)
                .chartYScale(domain: -5 ... 5)
            VStack(alignment: .leading) {
                Text("a: \(a)")
                Slider(value: $a, in: 1 ... 10, step: 0.1)
                Text("b: \(b)")
                Slider(value: $b, in: 1 ... 10, step: 0.1)
            }

        }.padding()
    }
}

#Preview {
    LissajousCurveView()
}
