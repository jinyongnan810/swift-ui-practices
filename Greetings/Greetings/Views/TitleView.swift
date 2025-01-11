//
//  TitleView.swift
//  Greetings
//
//  Created by Yuunan kin on 2025/01/10.
//

import SwiftUI

struct TitleView: View {
    @State private var subtitle = "Explore SwiftUI"
    let subtitles = [
        "Explore SwiftUI",
        "SwiftUI is a powerful tool for building user interfaces.",
        "SwiftUI is designed to be flexible and adaptable.",
        "SwiftUI is designed to be efficient and performant."
    ]

    let lineWidth: CGFloat = 15.0
    let circleSize: CGFloat = 70.0
    @State private var isRotated: Bool = false
    var rotation: Angle {
        isRotated ? .zero : .degrees(360)
    }
    var angularGradient: AngularGradient {
        AngularGradient(gradient: Gradient(colors: [.orange, .pink, .purple, .blue, .green]), center: .center)
    }

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Greetings")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                Text(subtitle)
                    .font(.headline)
                    .fontWeight(.light)
            }
            .onTapGesture {
                withAnimation(.spring()) {
                    subtitle = subtitles.randomElement() ?? "Explore SwiftUI"
                }
            }
            Spacer()
            Circle()
                .strokeBorder(
                    angularGradient,
                    lineWidth: lineWidth
                )
                .rotationEffect(rotation)
                .frame(width: circleSize, height: circleSize)
                .onTapGesture {
                    withAnimation(.spring()) {
                        isRotated.toggle()
                    }
                }
        }
    }
}

#Preview {
    VStack {
        TitleView().padding()
        Spacer()
    }
}
