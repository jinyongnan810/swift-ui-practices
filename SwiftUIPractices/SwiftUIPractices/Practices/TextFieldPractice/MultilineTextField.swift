//
//  MultilineTextField.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2025/01/25.
//

import SwiftUI

struct MultilineTextField: View {
    @State private var text = ""
    @FocusState private var isFocused
    var body: some View {
        TextField("Type Something and hit return", text: $text, axis: .vertical)
            .focused($isFocused)
            .onSubmit(of: .text) {
                text.append("\n")
                isFocused = true
            }.padding()
    }
}

#Preview {
    MultilineTextField()
}
