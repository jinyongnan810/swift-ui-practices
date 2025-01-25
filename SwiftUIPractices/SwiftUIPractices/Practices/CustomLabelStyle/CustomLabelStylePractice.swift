//
//  CustomLabelStylePractice.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2025/01/25.
//

import SwiftUI

struct CustomLabelStylePractice: View {
    var body: some View {
        Label("Hello World", systemImage: "globe")
        Label("Hello World", systemImage: "globe").labelStyle(MyLabelStyle())
    }
}

struct MyLabelStyle: LabelStyle {
    @State private var opacity: Double = 1
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.title
            configuration.icon
        }
        .opacity(opacity)
        .foregroundStyle(.white)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(
                    LinearGradient(
                        colors: [.purple, .cyan.opacity(0.6)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
        )
        .shadow(radius: 5)
        .onTapGesture {
            withAnimation {
                opacity = 0.3
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                withAnimation {
                    opacity = 1
                }
            }
        }
    }
}

#Preview {
    CustomLabelStylePractice()
}
