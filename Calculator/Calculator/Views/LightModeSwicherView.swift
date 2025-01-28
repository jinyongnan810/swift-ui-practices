//
//  LightModeSwicher.swift
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
        HStack {
            Image(systemName: "sun.max")
                .imageScale(.large)
                .fontWeight(.bold)
                .foregroundStyle(darkMode ? .disabled : .text)
                .padding(.trailing)
                .onTapGesture {
                    withAnimation {
                        darkMode = false
                    }
                }
            Image(systemName: "moon")
                .imageScale(.large)
                .fontWeight(.bold)
                .foregroundStyle(darkMode ? .text : .disabled)
                .padding(.leading)
                .onTapGesture {
                    withAnimation {
                        darkMode = true
                    }
                }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20).fill(.buttonsAreaBackground)
        )
    }
}

#Preview {
    LightModeSwicherView(darkMode: .constant(true))
}
