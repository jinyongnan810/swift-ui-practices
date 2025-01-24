//
//  ToolTipMessageView.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2025/01/24.
//

import SwiftUI

struct ToolTipMessageView: View {
    let text: String
    var body: some View {
        Text(text)
            .padding()
            .background(RoundedRectangle(cornerRadius: 20).fill(.cyan.gradient))
            .shadow(radius: 5)
    }
}

#Preview {
    ToolTipMessageView(text: "Hello, World!")
}
