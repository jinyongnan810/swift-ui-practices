//
//  ActionButton.swift
//  Calculator
//
//  Created by Yuunan kin on 2025/01/27.
//

import SwiftUI

struct ActionButtonView: View {
    let text: String
    let color: Color
    var body: some View {
        Text(text)
            .foregroundStyle(color)
            .font(.title)
            .fontWeight(.semibold)
            .frame(width: 60, height: 60)
            .background(
                RoundedRectangle(cornerRadius: 12).fill(Color.buttonBacground)
            ).padding()

    }
}

#Preview {
    ActionButtonView(text: "=", color: .red)
}
