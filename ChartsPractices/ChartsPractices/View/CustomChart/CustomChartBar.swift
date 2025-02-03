//
//  CustomChartBar.swift
//  ChartsPractices
//
//  Created by Yuunan kin on 2025/02/03.
//

import SwiftUI

struct CustomChartBar: View {
    let value: Int
    let color: Color
    let width: CGFloat
    var body: some View {
        VStack {
            Text("\(value)")
                .font(.headline)
            RoundedRectangle(cornerRadius: 8)
                .fill(color)
                .frame(width: width, height: CGFloat(value))
                .overlay {
                    RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 0.6)
                }
        }
    }
}
