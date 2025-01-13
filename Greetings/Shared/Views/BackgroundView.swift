//
//  BackgroundView.swift
//  Greetings
//
//  Created by Yuunan kin on 2025/01/10.
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: [.blue, .cyan]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        ).opacity(0.3)
            .ignoresSafeArea()
    }
}

#Preview {
    BackgroundView()
}
