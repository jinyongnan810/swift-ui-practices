//
//  RuleMarkView.swift
//  ChartsPractices
//
//  Created by Yuunan kin on 2025/02/04.
//

import Charts
import SwiftUI

struct RuleMarkView: ChartContent {
    var color: Color = .red
    let value: Double
    let key: String = "Sales"
    var isVertical: Bool = false
    var body: some ChartContent {
        if isVertical {
            return RuleMark(x: .value(key, value))
                .foregroundStyle(color)
                .lineStyle(.init(lineWidth: 2, dash: [5, 3]))
                .annotation(position: .bottom) {
                    Text("\(value, specifier: "%.1f")")
                        .font(.footnote)
                }
        }
        return RuleMark(y: .value(key, value))
            .foregroundStyle(color)
            .lineStyle(.init(lineWidth: 2, dash: [5, 3]))
            .annotation(position: .trailing) {
                Text("\(value, specifier: "%.1f")")
                    .font(.footnote)
            }
    }
}
