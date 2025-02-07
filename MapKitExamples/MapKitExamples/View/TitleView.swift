//
//  TitleView.swift
//  MapKitExamples
//
//  Created by Yuunan kin on 2025/02/07.
//

import SwiftUI

struct TitleView: View {
    var body: some View {
        LinearGradient(
            colors: [.blue, .purple, .pink, .red],
            startPoint: .leading,
            endPoint: .trailing
        ).mask {
            Text("MapKit Example")
                .font(.largeTitle)
        }.background(
            Material.ultraThin,
            in: RoundedRectangle(cornerRadius: 10)
        ).frame(width: 300, height: 100)
            .shadow(radius: 5)
    }
}

#Preview {
    TitleView()
}
