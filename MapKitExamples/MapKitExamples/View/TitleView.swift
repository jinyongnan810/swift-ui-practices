//
//  TitleView.swift
//  MapKitExamples
//
//  Created by Yuunan kin on 2025/02/07.
//

import SwiftUI

struct TitleView: View {
    var body: some View {
        Text("MapKit Example")
            .font(.largeTitle)
            .fontWeight(.bold)
            .padding()
            .foregroundStyle(LinearGradient(
                colors: [.blue, .purple, .pink, .red],
                startPoint: .leading,
                endPoint: .trailing
            )).background(
                Material.ultraThin
            )
            .clipShape(.rect(cornerRadius: 10))
            .shadow(radius: 5)
    }
}

#Preview {
    TitleView()
}
