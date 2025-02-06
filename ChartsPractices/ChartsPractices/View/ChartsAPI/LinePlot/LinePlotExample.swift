//
//  LinePlotExample.swift
//  ChartsPractices
//
//  Created by Yuunan kin on 2025/02/06.
//

import SwiftUI

struct LinePlotExample: View {
    var body: some View {
        NavigationStack {
            List {
                NavigationLink("Random Line Plot") {
                    RandomLinePlotView()
                }

                NavigationLink("Lissajous Curve") {
                    LissajousCurveView()
                }

                NavigationLink("Cosine and Taylor Polynomial") {
                    CosineTaylorPolynomialView()
                }
            }.navigationTitle("Line Plot Examples")
        }
    }
}

#Preview {
    LinePlotExample()
}
