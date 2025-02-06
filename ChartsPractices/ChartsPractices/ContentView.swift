//
//  ContentView.swift
//  ChartsPractices
//
//  Created by Yuunan kin on 2025/02/03.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            List {
                NavigationLink("Custom Charts", destination: CustomChartView())
                NavigationLink("Bar Chart", destination: BarChartsExample())
                NavigationLink("Line Plot", destination: LinePlotExample())
            }.navigationTitle("Chart Practices")
        }
    }
}

#Preview {
    ContentView()
}
