//
//  RandomLinePlotView.swift
//  ChartsPractices
//
//  Created by Yuunan kin on 2025/02/06.
//

import Charts
import SwiftUI

struct RandomLinePlotView: View {
    let data: [(Double, Float)] = stride(from: 0, to: 20, by: 1).map { x in
        (x, Float.random(in: 0 ... 100))
    }

    var body: some View {
        Chart(data, id: \.0) {
            x, y in
            LinePlot(data, x: .value("x", x), y: .value("y", y))
        }.padding()
    }
}

#Preview {
    RandomLinePlotView()
}
