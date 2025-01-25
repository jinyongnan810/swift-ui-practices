//
//  MyToastView.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2025/01/26.
//

import SwiftUI

struct MyToastView: View {
    let text: String

    var body: some View {
        Text(text)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .foregroundStyle(.white)
            .background(Color.black.gradient)
            .cornerRadius(12)
            .frame(maxHeight: .infinity, alignment: .bottom)
    }
}

#Preview {
    MyToastView(text: "Hello World!")
}
