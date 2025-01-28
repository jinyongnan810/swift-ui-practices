//
//  ActionButton.swift
//  Calculator
//
//  Created by Yuunan kin on 2025/01/27.
//

import SwiftUI

struct ActionButtonView: View {
    @State var isPressed: Bool = false
    let text: String
    let color: Color
    var textOpacity: Double {
        isPressed ? 0.4 : 1
    }
    var backgroundColor: Color {
        isPressed ? Color.gray : Color.buttonBacground
    }
    var body: some View {
        Text(text)
            .foregroundStyle(color)
            .font(.title)
            .fontWeight(.semibold)
            .opacity(textOpacity)
            .frame(width: 60, height: 60)
            .background(
                RoundedRectangle(cornerRadius: 12).fill(backgroundColor)
            ).padding()
            .onTapGesture {
                withAnimation {
                    isPressed = true
                }

                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                    withAnimation {
                        isPressed = false
                    }
                })
            }

    }
}

#Preview {
    ActionButtonView(text: "=", color: .red)
}
