//
//  AlternativeButtonView.swift
//  Shuzi
//
//  Created by Yuunan kin on 2025/02/01.
//

import SwiftUI

struct AlternativeButtonView: View {
    let text: String
    let color: Color
    var body: some View {
        Circle()
            .fill(color)
            .frame(width: 150, height: 150)
            .overlay {
                Text(text)
                    .font(.title)
                    .foregroundStyle(.white)
                    .fontWeight(.semibold)
            }
    }
}

#Preview {
    AlternativeButtonView(text: "11", color: .blue)
}
