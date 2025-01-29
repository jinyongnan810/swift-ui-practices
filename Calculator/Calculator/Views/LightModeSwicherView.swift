//
//  LightModeSwicherView.swift
//  Calculator
//
//  Created by Yuunan kin on 2025/01/27.
//

import SwiftUI

enum RenderType: String, CaseIterable {
    case light
    case dark
}

struct LightModeSwicherView: View {
    @Binding var darkMode: Bool

    var body: some View {
        HStack(spacing: 30) {
            Image(systemName: "sun.max")
                .imageScale(.large)
                .fontWeight(.bold)
                .foregroundStyle(darkMode ? .disabled : .text)
            Image(systemName: "moon")
                .imageScale(.large)
                .fontWeight(.bold)
                .foregroundStyle(darkMode ? .text : .disabled)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20).fill(.buttonsAreaBackground)
        )
        .onTapGesture {
            withAnimation {
                darkMode.toggle()
            }
        }
    }
}

#Preview {
    LightModeSwicherView(darkMode: .constant(true))
}
