//
//  OnboardingPractice.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2026/02/18.
//

import SwiftUI

private struct OnboardingAnimationProperties {
    var animateMainCircle: Bool = false
    var subCirclesSize: CGFloat = 50
    var subCirclesOffset: CGFloat = 0
    var subCirclesScale: CGFloat = 0
    var subCirclesTakePosition: Bool = false
}

struct OnboardingPractice: View {
    let tint = Color.blue
    @State private var animationProperties: OnboardingAnimationProperties = .init()
    var body: some View {
        ZStack {
            Text("Contents")
            OnboardingView()
                .padding()
        }
    }

    @ViewBuilder
    func OnboardingView() -> some View {
        GeometryReader { geo in
            let size = min(geo.size.width, geo.size.height)
            ZStack {
                Circle()
                    .fill(tint.gradient)
                    .scaleEffect(animationProperties.animateMainCircle ? 2 : 0)
                Circles()
            }
            .frame(width: size, height: size)
            .clipShape(.rect(cornerRadius: 30))
        }.onAppear {
            guard !animationProperties.animateMainCircle else { return }
            Task {
                await delayAnimation(0.1, .easeInOut(duration: 0.5), perform: {
                    animationProperties.animateMainCircle = true
                })
                await delayAnimation(0.1, .bouncy(duration: 0.6, extraBounce: 0.2), perform: {
                    animationProperties.subCirclesScale = 1
                })
                await delayAnimation(0.3, .bouncy(duration: 0.5), perform: {
                    animationProperties.subCirclesOffset = 50
                })
                await delayAnimation(0.1, .bouncy(duration: 0.4), perform: {
                    animationProperties.subCirclesSize = 5
                })
                try await withThrowingTaskGroup(of: Void.self) { group in
                    group.addTask { await delayAnimation(0.2, .linear(duration: 0.4), perform: {
                        animationProperties.subCirclesTakePosition = true
                    }) }
                    group.addTask { await delayAnimation(0.3, .linear(duration: 0.4), perform: {
                        animationProperties.subCirclesScale = 0
                    }) }
                    try await group.waitForAll()
                }
            }
        }
    }

    @ViewBuilder
    func Circles() -> some View {
        ZStack {
            ForEach(1 ... 4, id: \.self) { i in
                let rotation: Double = 90 * Double(i)
                let extraRotation: Double = animationProperties.subCirclesTakePosition ? 20 : 0
                let extraOffset: CGFloat = i % 2 == 0 ? 40 : -20
                Circle()
                    .fill(.white)
                    .frame(width: animationProperties.subCirclesSize)
                    .scaleEffect(animationProperties.subCirclesScale)
                    .offset(
                        x: 0,
                        y: animationProperties.subCirclesTakePosition ? (
                            120 + extraOffset
                        ) : animationProperties.subCirclesOffset
                    )
                    .rotationEffect(.degrees(CGFloat(rotation + extraRotation)))
            }
        }
    }

    func delayAnimation(
        _ delay: Double,
        _ animation: Animation,
        perform action: @escaping () -> Void
    ) async {
        try? await Task.sleep(for: .seconds(delay))
        withAnimation(animation) {
            action()
        }
    }
}

#Preview {
    OnboardingPractice()
}
