//
//  BarChartsExample.swift
//  ChartsPractices
//
//  Created by Yuunan kin on 2025/02/04.
//

import Charts
import SwiftUI

enum TabType: String, CaseIterable {
    case bar
    case barRotated
    case line
    case area
}

struct BarChartsExample: View {
    @State private var isLegendVisible: Bool = true
    @State private var tabType: TabType = .bar
    @State private var viewModel: BarChartsViewModel = .init()
    @State private var isEditing: Bool = false
    @State private var currentDraggingItemKey: String? = nil

    var body: some View {
        NavigationStack {
            TabView {
                Tab(TabType.bar.rawValue, systemImage: "chart.bar.xaxis") {
                    Chart {
                        ForEach(viewModel.data) { item in
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
                        RuleMarkView(color: .cyan, value: viewModel.averageSales)
                    }
                    .chartForegroundStyleScale(range: viewModel.barColors)
                    .chartOverlay(
                        content: { chartProxy in
                            if isEditing {
                                Rectangle()
                                    .fill(.gray.opacity(0.2))
                                    .gesture(
                                        DragGesture()
                                            .onChanged { value in
                                                let location = value.location
                                                let (selectedMonth, updatedValue) = chartProxy.value(at: location, as: (String, Double).self) ?? ("", 0.0)
                                                if selectedMonth.isEmpty {
                                                    return
                                                } else if currentDraggingItemKey == nil {
                                                    currentDraggingItemKey = selectedMonth
                                                }
                                                viewModel
                                                    .updateDataFor(
                                                        key: currentDraggingItemKey ?? "",
                                                        value: updatedValue
                                                    )
                                            }
                                            .onEnded { _ in
                                                currentDraggingItemKey = nil
                                            }
                                    )
                            }

                        })
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
                        ForEach(viewModel.data) { item in
                            BarMark(x: .value("Sales", item.value),
                                    y: .value("Month", item.label))
                                .foregroundStyle(by: .value("Month", item.label))
                                .annotation(position: .trailing) {
                                    Image(systemName: item.systemImage)
                                        .foregroundStyle(item.color)
                                }
                        }
                        RuleMarkView(color: .cyan, value: viewModel.averageSales, isVertical: true)
                    }
                    .chartForegroundStyleScale(range: viewModel.barColors)
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
                        ForEach(viewModel.data) { item in
                            LineMark(x: .value("Month", item.label),
                                     y: .value("Sales", item.value))
                        }
                        RuleMarkView(color: .cyan, value: viewModel.averageSales)
                    }
                }
                Tab(TabType.area.rawValue, systemImage: "chart.line.uptrend.xyaxis") {
                    Chart {
                        ForEach(viewModel.data) { item in
                            AreaMark(x: .value("Month", item.label),
                                     y: .value("Sales", item.value))
                        }
                        RuleMarkView(color: .cyan, value: viewModel.averageSales)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        withAnimation {
                            isEditing.toggle()
                        }
                    }) {
                        Text(isEditing ? "Done" : "Edit")
                    }
                }
            }
        }
    }
}

#Preview {
    BarChartsExample()
}
