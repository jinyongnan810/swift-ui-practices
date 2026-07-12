//
//  GlassSlider.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2026/07/12.
//  Learned from Kavsoft: https://youtu.be/vp5sLEyI8g8
//

import SwiftUI

struct GlassSliderPractice: View {
    var body: some View {
        GlassSlider(
            text: "Hello, World!",
            iconName: "star.fill",
            config: .init(tint: .blue)
        ) { progress in
            print("progress: \(progress)")
        } onFinished: {
            print("finished")
        }
        .padding()
    }
}

struct GlassSlider: View {
    let text: String
    let iconName: String
    let config: Config
    struct Config {
        var tint: Color
        var size: CGFloat = 100
    }

    let onProgressChanged: (CGFloat) -> Void
    let onFinished: () -> Void

    @State private var offset: CGFloat = 0

    var body: some View {
        GeometryReader { proxy in
            let sliderWidth = proxy.size.width

            ZStack(alignment: .leading) {
                Capsule().fill(config.tint.opacity(0.05))
                    .glassEffect(.regular)
                ZStack(alignment: .leading) {
                    Text(text)
                        .font(.title)
                        .foregroundStyle(config.tint.secondary)
                    // use rectangle mask to make shimmer text
                    Text(text)
                        .font(.title)
                        .foregroundStyle(config.tint)
                        .mask(alignment: .leading) {
                            GeometryReader { proxy in
                                let size = proxy.size
                                let maskWidth: CGFloat = 50
                                let width: CGFloat = size.width + maskWidth

                                Rectangle()
                                    .frame(width: 15)
                                    .blur(radius: 5)
                                    .rotationEffect(.degrees(12))
                                    .offset(x: -maskWidth)
                                    .keyframeAnimator(
                                        initialValue: CGFloat.zero,
                                        repeating: true
                                    ) { content, offset in
                                        content.offset(x: offset)
                                    } keyframes: { _ in
                                        LinearKeyframe(width, duration: 3)
                                    }
                            }
                        }
                }.frame(maxWidth: .infinity, maxHeight: .infinity)

                Image(systemName: iconName)
                    .foregroundStyle(config.tint)
                    .font(.title)
                    .frame(width: config.size, height: config.size)
                    // pulse effect
                    .keyframeAnimator(
                        initialValue: 0,
                        repeating: true,
                        content: {
                            content,
                                opacity in
                            content
                                .shadow(
                                    color: config.tint.opacity(opacity),
                                    radius: 5
                                )
                        },
                        keyframes: { _ in
                            LinearKeyframe(1, duration: 3)
                            LinearKeyframe(0, duration: 3)
                        }
                    )
                    .glassEffect(.clear, in: .circle)
                    .offset(x: offset)
                    // gesture must be behind offset to avoid jittering
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { value in
                                let maxOffset = max(sliderWidth - config.size, 0)
                                let cappedOffset = min(max(value.translation.width, 0), maxOffset)

                                offset = cappedOffset
                                onProgressChanged(maxOffset == 0 ? 0 : cappedOffset / maxOffset)
                            }
                            .onEnded { value in
                                let maxOffset = max(sliderWidth - config.size, 0)
                                let cappedOffset = min(max(value.translation.width, 0), maxOffset)

                                if maxOffset > 0, cappedOffset >= maxOffset {
                                    onFinished()
                                    return
                                }

                                withAnimation {
                                    offset = 0
                                }
                            }
                    )
            }
        }
        .frame(height: config.size)
    }
}

#Preview {
    GlassSliderPractice()
}
