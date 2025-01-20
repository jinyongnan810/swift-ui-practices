//
//  GestureStateExample.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2025/01/20.
//

import SwiftUI

struct GestureStateExample: View {
    @GestureState private var scale: CGFloat = 1
    var body: some View {
        NavigationStack {
            MyTextView(text: "Auto Bounce Back")
                .scaleEffect(scale)
                .animation(.spring, value: scale)
                .gesture(
                    MagnificationGesture()
                        .updating($scale, body: { value, state, _ in
                            state = value.magnitude
                        })
                ).navigationTitle("@GestureState")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    GestureStateExample()
}
