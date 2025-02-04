//
//  BarChartsExample.swift
//  ChartsPractices
//
//  Created by Yuunan kin on 2025/02/04.
//

import Charts
import SwiftUI

struct BarChartData: Identifiable {
    let id: UUID = .init()
    let label: String
    let value: Double
    let color: Color
    let systemImage: String
}

private let data: [BarChartData] = [
    .init(label: "January", value: 81.4, color: .blueViolet, systemImage: "sun.max"),
    .init(
        label: "February",
        value: 284.1,
        color: .antiqueWhite,
        systemImage: "moon"
    ),
    .init(label: "March", value: 82.3, color: .aqua, systemImage: "cloud.sun"),
    .init(
        label: "April",
        value: 187.6,
        color: .beige,
        systemImage: "cloud.sun.rain"
    ),
    .init(
        label: "May",
        value: 92.4,
        color: .bisque,
        systemImage: "cloud.sun.bolt"
    ),
    .init(label: "June", value: 94.5, color: .purple, systemImage: "cloud.sun.rain.fill"),
    .init(label: "July", value: 102.1, color: .pink, systemImage: "cloud.sun.bolt.fill"),
    .init(
        label: "August",
        value: 112.4,
        color: .burlyWood,
        systemImage: "cloud.sun.rain.fill"
    ),
    .init(
        label: "September",
        value: 122.1,
        color: .darkCyan,
        systemImage: "cloud.sun.bolt.fill"
    ),
    .init(
        label: "October",
        value: 112.4,
        color: .darkOrchid,
        systemImage: "cloud.sun.rain.fill"
    ),
    .init(
        label: "November",
        value: 92.4,
        color: .lavender,
        systemImage: "cloud.sun.bolt"
    ),
    .init(
        label: "December",
        value: 82.3,
        color: .lightSteelBlue,
        systemImage: "cloud.sun"
    ),
]

enum TabType: String, CaseIterable {
    case bar
    case barRotated
    case line
    case area
}

private let barColors: [Color] = data.map(\.color)

struct BarChartsExample: View {
    @State private var isLegendVisible: Bool = true
    @State private var tabType: TabType = .bar
    private var averageSales: Double {
        data.map(\.value).reduce(0.0, +) / Double(data.count)
    }

    var body: some View {
        TabView {
            Tab(TabType.bar.rawValue, systemImage: "chart.bar.xaxis") {
                Chart {
                    ForEach(data) { item in
                        BarMark(x: .value("Month", item.label),
                                y: .value("Sales", item.value))
                            //                .foregroundStyle(item.color)
                            .foregroundStyle(by: .value("Month", item.label))
                            .annotation {
                                Image(systemName: item.systemImage)
                                    .foregroundStyle(item.color)
                            }
                    }
                    BarMark(x: .value("Month", "January"),
                            y: .value("Sales", 50))
                        .foregroundStyle(by: .value("Month", "Jan #2"))
                    RuleMarkView(color: .cyan, value: averageSales)
                }
                .chartForegroundStyleScale(range: barColors)
                .onTapGesture {
                    withAnimation {
                        isLegendVisible.toggle()
                    }
                }
                .chartYScale(domain: 0.0 ... 300.0)
                //            .chartXAxis {
                //                AxisMarks(position: .top)
                //            }
                .chartLegend(isLegendVisible ? .visible : .hidden)
                //            .chartLegend(position: .leading)
                .padding()
            }
            Tab(TabType.barRotated.rawValue, systemImage: "chart.bar.yaxis") {
                Chart {
                    ForEach(data) { item in
                        BarMark(x: .value("Sales", item.value),
                                y: .value("Month", item.label))
                            .foregroundStyle(by: .value("Month", item.label))
                            .annotation(position: .trailing) {
                                Image(systemName: item.systemImage)
                                    .foregroundStyle(item.color)
                            }
                    }
                    RuleMarkView(color: .cyan, value: averageSales, isVertical: true)
                }
                .chartForegroundStyleScale(range: barColors)
                .onTapGesture {
                    withAnimation {
                        isLegendVisible.toggle()
                    }
                }
                .chartLegend(isLegendVisible ? .visible : .hidden)
                .padding()
            }

            Tab(TabType.line.rawValue, systemImage: "chart.line.uptrend.xyaxis") {
                Chart {
                    ForEach(data) { item in
                        LineMark(x: .value("Month", item.label),
                                 y: .value("Sales", item.value))
                    }
                    RuleMarkView(color: .cyan, value: averageSales)
                }
            }
            Tab(TabType.area.rawValue, systemImage: "chart.line.uptrend.xyaxis") {
                Chart {
                    ForEach(data) { item in
                        AreaMark(x: .value("Month", item.label),
                                 y: .value("Sales", item.value))
                    }
                    RuleMarkView(color: .cyan, value: averageSales)
                }
            }
        }
    }
}

#Preview {
    BarChartsExample()
}
