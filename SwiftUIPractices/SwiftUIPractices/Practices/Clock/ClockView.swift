//
//  ClockView.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2025/08/31.
//

import SwiftUI

struct ClockView: View {
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [.cyan, .purple],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            ).ignoresSafeArea()
            VStack {
                AnalogClock()
                DigitalClock()
            }
        }
    }
}

#Preview {
    ClockView()
}
