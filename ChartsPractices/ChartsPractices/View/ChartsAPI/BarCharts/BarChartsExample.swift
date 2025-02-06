//
//  BarChartsExample.swift
//  ChartsPractices
//
//  Created by Yuunan kin on 2025/02/04.
//

import Charts
import SwiftUI
// official reference: https://www.youtube.com/watch?v=5jzLaxQwbBU
struct BarChartsExample: View {
    @State private var isLegendVisible: Bool = true
    @State private var viewModel: BarChartsViewModel = .init()
    @State private var isEditing: Bool = false
    @State private var currentDraggingItemKey: String? = nil

    var selectedItem: BarChartData? {
        if let key = currentDraggingItemKey {
            return viewModel.data
                .first { $0.label == key }
        }
        return nil
    }

    var body: some View {
        NavigationStack {
            TabView {
                Tab("Bar", systemImage: "chart.bar.xaxis") {
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
                                .accessibilityLabel(item.label)
                                .accessibilityValue(Text("\(item.value) sales"))
                        }
                        BarMark(x: .value("Month", "January"),
                                y: .value("Sales", 50))
                            .foregroundStyle(by: .value("Month", "Jan #2"))
                        RuleMarkView(color: .cyan, value: viewModel.averageSales)
                        if selectedItem != nil {
                            RuleMarkView(
                                color: selectedItem!.color,
                                value: selectedItem!.value
                            )
                        }
                    }
                    .chartForegroundStyleScale(range: viewModel.barColors)
                    .modifier(
                        ChartDragModifier(
                            currentDraggingItemKey: $currentDraggingItemKey,
                            isEditing: $isEditing,
                            viewModel: $viewModel
                        )
                    )
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
                Tab("Horizontal Bar", systemImage: "chart.bar.yaxis") {
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
                        if selectedItem != nil {
                            RuleMarkView(
                                color: selectedItem!.color,
                                value: selectedItem!.value,
                                isVertical: true
                            )
                        }
                    }
                    .chartForegroundStyleScale(range: viewModel.barColors)
                    .modifier(
                        ChartDragHorizontalModifier(
                            currentDraggingItemKey: $currentDraggingItemKey,
                            isEditing: $isEditing,
                            viewModel: $viewModel
                        )
                    )
                    .onTapGesture {
                        withAnimation {
                            isLegendVisible.toggle()
                        }
                    }
                    .chartXScale(domain: 0.0 ... 300.0)
                    .chartLegend(isLegendVisible ? .visible : .hidden)
                    .padding()
                }

                Tab("Line And Area", systemImage: "chart.line.uptrend.xyaxis") {
                    Chart {
                        ForEach(viewModel.data) { item in
                            LineMark(x: .value("Month", item.label),
                                     y: .value("Sales", item.value))
                                .symbol {
                                    Image(systemName: "square.and.pencil")
                                        .imageScale(.large)
                                }.interpolationMethod(.catmullRom)

                            AreaMark(x: .value("Month", item.label),
                                     y: .value("Sales", item.value))
                                .foregroundStyle(.blue.opacity(0.2))
                                .interpolationMethod(.catmullRom)
                        }
                        RuleMarkView(color: .cyan, value: viewModel.averageSales)
                        if selectedItem != nil {
                            RuleMarkView(
                                color: selectedItem!.color,
                                value: selectedItem!.value
                            )
                        }
                    }.modifier(
                        ChartDragModifier(
                            currentDraggingItemKey: $currentDraggingItemKey,
                            isEditing: $isEditing,
                            viewModel: $viewModel
                        )
                    ).padding()
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
