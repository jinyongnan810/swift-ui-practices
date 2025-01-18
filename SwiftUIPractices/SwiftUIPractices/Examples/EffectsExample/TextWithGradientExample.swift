//
//  TextWithGradientExample.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2025/01/18.
//

import SwiftUI

struct TextWithGradientExample: View {
    var body: some View {
        LinearGradient(
            colors: [.red, .purple],
            startPoint: .leading,
            endPoint: .trailing
        ).mask {
            Text("Text With Gradient")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    TextWithGradientExample()
}
