//
//  ChartDragModifier.swift
//  ChartsPractices
//
//  Created by Yuunan kin on 2025/02/04.
//

import SwiftUI

struct ChartDragModifier: ViewModifier {
    @Binding var currentDraggingItemKey: String?
    @Binding var isEditing: Bool
    @Binding var viewModel: BarChartsViewModel
    func body(content: Content) -> some View {
        content
            .chartOverlay(
                content: { chartProxy in
                    if isEditing {
                        Rectangle()
                            .fill(.clear)
                            .contentShape(Rectangle())
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
    }
}

struct ChartDragHorizontalModifier: ViewModifier {
    @Binding var currentDraggingItemKey: String?
    @Binding var isEditing: Bool
    @Binding var viewModel: BarChartsViewModel
    func body(content: Content) -> some View {
        content
            .chartOverlay(
                content: { chartProxy in
                    if isEditing {
                        Rectangle()
                            .fill(.clear)
                            .contentShape(Rectangle())
                            .gesture(
                                DragGesture()
                                    .onChanged { value in

                                        let location = value.location
                                        let (updatedValue, selectedMonth) = chartProxy.value(at: location, as: (Double, String).self) ?? (0.0, "")
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
    }
}
