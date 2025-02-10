//
//  BubbleView.swift
//  AddingGame
//
//  Created by Yuunan kin on 2025/02/11.
//

import SwiftUI

enum BubbleType: String {
    case bubble1, bubble2, bubble3
}

struct BubbleView: View {
    let size: CGFloat
    let text: String
    let type: BubbleType
    @State var rotateAngle: Angle = .zero
//    var animation: Animation {
//        .linear(duration: 0.4)
//        .repeatForever(autoreverses: false)
//    }
//    var timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    var body: some View {
        ZStack {
            Image(type.rawValue)
                .resizable()
                .scaledToFit()
                .frame(width: size, height: size)
                .rotationEffect(rotateAngle)
                .onAppear {
                    withAnimation(
                        .linear(duration: 30).repeatForever(autoreverses: false)
                    ) {
                        rotateAngle = .degrees(360)
                    }
                }
//                .animation(animation, value: rotateAngle)
//                .onReceive(timer) { _ in
//                    rotateAngle += .degrees(1)
//                }
            Text(text)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(.white)
        }
    }
}

#Preview {
    BubbleView(size: 100, text: "77", type: .bubble1)
}
