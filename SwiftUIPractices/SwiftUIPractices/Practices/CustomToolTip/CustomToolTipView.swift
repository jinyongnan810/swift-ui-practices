//
//  CustomToolTipView.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2025/01/24.
//

import SwiftUI

struct CustomToolTipView<Content: View, Message: View>: View {
    let content: Content
    let message: Message

//    @GestureState private var isShowingToolTip: Bool = false
    @State private var isShowingToolTip: Bool = false

    init(
        @ViewBuilder content: @escaping () -> Content,
        @ViewBuilder message: @escaping () -> Message
    ) {
        self.content = content()
        self.message = message()
    }

    var longPressGesture: some Gesture {
        LongPressGesture(minimumDuration: 0.4)
            .onEnded { _ in
                isShowingToolTip = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    isShowingToolTip = false
                }
            }
//            .updating($isShowingToolTip) { currentState, gestureState, transaction in
//                print("⭐️")
//                gestureState = currentState
//            }
    }

    var body: some View {
        ZStack {
            content.gesture(longPressGesture)
            message.opacity(isShowingToolTip ? 1 : 0)
                .animation(.spring, value: isShowingToolTip)
        }
    }
}

#Preview {
    CustomToolTipView {
        Text("hello").padding().background(.orange)
    } message: {
        Text("world").padding().background(.green)
    }
}
