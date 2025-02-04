//
//  BarChartsViewModel.swift
//  ChartsPractices
//
//  Created by Yuunan kin on 2025/02/04.
//

import Observation
import SwiftUI

@Observable
class BarChartsViewModel {
    var data: [BarChartData] = [
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
    var averageSales: Double {
        data.map(\.value).reduce(0.0, +) / Double(data.count)
    }

    var barColors: [Color] {
        data.map(\.color)
    }

    func updateDataFor(key: String, value: Double) {
        if let idx = data.firstIndex(where: { item in
            item.label == key
        }) {
            data[idx].value = value
        }
    }
}
