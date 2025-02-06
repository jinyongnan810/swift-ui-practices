//
//  CosineTaylorPolynomialView.swift
//  ChartsPractices
//
//  Created by Yuunan kin on 2025/02/06.
//

import Charts
import SwiftUI

var factorialCache: [Int: Int] = [:]
func taylorSeries(x: Double, n: Double) -> Double {
    var result: Double = 1

    for i in 1 ... Int(n) {
        result += (pow(-1, Double(i)) / Double(factorial(i * 2)))
        * pow(x, Double(i * 2))
    }
    return result
}

func factorial(_ n: Int) -> Int {
    if n == 0 {
        return 1
    }
    if let cachedResult = factorialCache[n] {
        return cachedResult
    }
    factorialCache[n] = n * factorial(n - 1)
    return n * factorial(n - 1)
}

// https://ja.wikipedia.org/wiki/テイラー展開
struct CosineTaylorPolynomialView: View {
    @State private var n = 1.0

    var body: some View {
        VStack {
            Chart { [n] in
                LinePlot(x: "x", y: "y") { x in
                    cos(x)
                }.foregroundStyle(.green)
                LinePlot(x: "x", y: "y") { _ in
                    1
                }.foregroundStyle(.black)
                LinePlot(x: "x", y: "y") { x in
                    taylorSeries(x: x, n: n)
                }.foregroundStyle(.red)
            }
            .chartXScale(domain: -10 ... 10)
            .chartYScale(domain: -10 ... 10)
            .aspectRatio(contentMode: .fit)
            .padding()

            Text("n = \(n.formatted())")
            Slider(value: $n, in: 1 ... 10, step: 1)
        }.padding()
    }
}

#Preview {
    CosineTaylorPolynomialView()
}
