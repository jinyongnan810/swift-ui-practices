//
//  ToastPractice.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2025/01/26.
//

import SwiftUI

struct ToastPractice: View {
    @State private var showToast: Bool = false
    var buttonText: String {
        showToast ? "Hide Toast" : "Show Toast"
    }

    var body: some View {
        Button {
            withAnimation {
                showToast.toggle()
            }
        } label: {
            Text(buttonText)
        }.toast(text: "Hello, Toast!", isShowing: $showToast)
    }
}

extension View {
    func toast(text: String, isShowing: Binding<Bool>) -> some View {
        modifier(MyToastModifier(text: text, isShowing: isShowing))
    }
}

#Preview {
    ToastPractice()
}
