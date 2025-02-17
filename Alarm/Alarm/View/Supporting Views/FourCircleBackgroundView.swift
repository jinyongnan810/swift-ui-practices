//
//  FourCircleBackgroundView.swift
//  Alarm
//
//  Created by Yuunan kin on 2025/02/14.
//

import SwiftUI

struct FourCircleBackgroundView: View {
    let color1: Color
    let color2: Color
    @State var offset1: CGSize = .init(width: 0, height: 0)
    @State var offset2: CGSize = .init(width: 0, height: 0)
    @State var offset3: CGSize = .init(width: 0, height: 0)
    @State var offset4: CGSize = .init(width: 0, height: 0)
    @State var size1: CGFloat = 100
    @State var size2: CGFloat = 50
    @State var size3: CGFloat = 70
    @State var size4: CGFloat = 120
    let maxX = screenWidth * 0.5
    let maxY = screenHeight * 0.5
    let minSize = screenWidth * 0.05
    let maxSize = screenWidth * 0.4

    let timer = Timer.publish(every: 1, on: .main, in: .common)
        .autoconnect()

    var body: some View {
        ZStack {
            CircleView(color1: color1, color2: color2)
                .frame(width: size1)
                .offset(x: maxX * 0.2, y: maxY * 0.9)
                .offset(offset1)
            CircleView(color1: color1, color2: color2)
                .frame(width: size2)
                .offset(x: -maxX * 0.4, y: maxY * 0.1)
                .offset(offset2)
            CircleView(color1: color1, color2: color2)
                .frame(width: size3)
                .offset(x: maxX * 0.75, y: -maxY * 0.3)
                .offset(offset3)
            CircleView(color1: color1, color2: color2)
                .frame(width: size4)
                .offset(x: -maxX * 0.6, y: -maxY * 0.7)
                .offset(offset4)
                .onReceive(timer) { _ in
                    withAnimation(.easeIn(duration: 40)) {
                        offset1 = getRandomOffset()
                        offset2 = getRandomOffset()
                        offset3 = getRandomOffset()
                        offset4 = getRandomOffset()
                        size1 = CGFloat.random(in: minSize ... maxSize)
                        size2 = CGFloat.random(in: minSize ... maxSize)
                        size3 = CGFloat.random(in: minSize ... maxSize)
                        size4 = CGFloat.random(in: minSize ... maxSize)
                    }
                }
        }
    }

    func getRandomOffset() -> CGSize {
        CGSize(
            width: CGFloat.random(in: -150 ... 150),
            height: CGFloat.random(in: -150 ... 150)
        )
    }
}

struct CircleView: View {
    let color1: Color
    let color2: Color
    var body: some View {
        Circle()
            .fill(
                LinearGradient(
                    colors: [color1, color2],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
    }
}

#Preview {
    FourCircleBackgroundView(color1: .myBlue, color2: .clear)
}
