//
//  AlarmView.swift
//  Alarm
//
//  Created by Yuunan kin on 2025/02/12.
//

import SwiftUI

struct AlarmView: View {
    var body: some View {
        ZStack {
            FourCircleBackgroundView(color1: .myYellow, color2: .clear)
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("Hello, world!")
            }
            .padding()
        }
    }
}

#Preview {
    AlarmView()
}
