//
//  WeightView.swift
//  BodyShape
//
//  Created by Yuunan kin on 2025/03/03.
//

import SwiftUI

struct WeightView: View {
    var weight: Double = 61.20
    var body: some View {
        HStack(spacing: 20) {
            VStack(alignment: .leading) {
                NumberWithUnit {
                    Text("\(weight, specifier: "%.2f")")
                        .font(.title)
                        .fontWeight(.bold)
                }
                Text("Current Weight")
                    .font(.headline)
                    .foregroundStyle(.gray)
            }
            Spacer()
            VStack(alignment: .leading) {
                NumberWithUnit {
                    Text("2.5")
                        .font(.title2)
                }
                ProgressBarView(progress: 0.25)
                Text("Left to Gain")
                    .font(.headline)
                    .foregroundStyle(.gray)
            }
        }
    }
}

#Preview {
    WeightView()
}
