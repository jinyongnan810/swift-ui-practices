//
//  BarChartData.swift
//  ChartsPractices
//
//  Created by Yuunan kin on 2025/02/04.
//
import SwiftUI

struct BarChartData: Identifiable {
    let id: UUID = .init()
    let label: String
    var value: Double
    let color: Color
    let systemImage: String
}
