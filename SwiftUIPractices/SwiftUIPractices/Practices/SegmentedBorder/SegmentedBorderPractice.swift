//
//  SegmentedBorderPractice.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2025/01/24.
//

import SwiftUI

struct SegmentedBorderPractice: View {
    let numberOfPeople: Int = 8
    var sizeForEach: Double {
        1 / Double(numberOfPeople)
    }

    let colors: [Color] = [
        .red,
        .orange,
        .blue,
        .pink,
        .green,
        .yellow,
        .purple,
        .black,
        .cyan,
    ]

    var body: some View {
        ZStack {
            Capsule()
                .fill(.cyan.opacity(0.2))
            ForEach(0 ..< numberOfPeople, id: \.self) { i in
                // animation does not work in here, because these won't work
                // from: 0.8, to: 1.1
                // from: 0.8, to: 0.1
                Capsule()
                    .trim(from: Double(i) * sizeForEach, to: Double(1 + i) * sizeForEach)
                    .stroke(colors[i % colors.count], lineWidth: 10)
                    .blur(radius: 15)
            }

            ForEach(0 ..< numberOfPeople, id: \.self) { i in
                let start = Double(i) * sizeForEach
                let middle = start + sizeForEach / 2
                Capsule()
                    .trim(from: middle, to: middle + 0.01)
                    .stroke(colors[i % colors.count], style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
            }

        }.frame(width: 200, height: 300)
    }
}

#Preview {
    SegmentedBorderPractice()
}
