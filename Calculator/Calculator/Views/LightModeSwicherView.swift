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
    @AppStorage("mode") var mode: RenderType = .light

    var body: some View {
        HStack {
            Image(systemName: "sun.max")
                .imageScale(.large)
                .fontWeight(.bold)
                .foregroundStyle(mode == .light ? .text : .disabled)
                .padding(.trailing)
                .onTapGesture {
                    withAnimation {
                        mode = .light
                    }

                }
            Image(systemName: "moon")
                .imageScale(.large)
                .fontWeight(.bold)
                .foregroundStyle(mode == .dark ? .text : .disabled)
                .padding(.leading)
                .onTapGesture {
                    withAnimation {
                        mode = .dark
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
    LightModeSwicherView()
}
