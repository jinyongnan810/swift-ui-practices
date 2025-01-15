//
//  TextSliderView.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2025/01/15.
//

import SwiftUI

struct TextSliderView: View {
    let title: String
    @Binding var value: Double
    let min: Double
    let max: Double
    var body: some View {
        VStack(alignment: .leading) {
            Text(title).font(.headline)
            Slider(value: $value, in: min...max, step: 1)
        }
    }
}

#Preview {
    TextSliderView(title: "Test Slider", value: .constant(30.0), min: 0.0, max: 50.0)
}
