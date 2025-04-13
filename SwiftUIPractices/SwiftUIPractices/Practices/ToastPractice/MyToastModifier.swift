//
//  MyToastModifier.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2025/01/26.
//

import SwiftUI

struct MyToastModifier: ViewModifier {
    let text: String
    let duration: Double
    @Binding var isShowing: Bool
    var offset: CGFloat {
        isShowing ? 0 : 100
    }

    func body(content: Content) -> some View {
        ZStack {
            content
            MyToastView(text: text)
                .offset(y: offset)
        }.onChange(of: isShowing) { oldValue, newValue in
            if oldValue != newValue, newValue {
                DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                    withAnimation {
                        isShowing = false
                    }
                }
            }
        }
    }
}
