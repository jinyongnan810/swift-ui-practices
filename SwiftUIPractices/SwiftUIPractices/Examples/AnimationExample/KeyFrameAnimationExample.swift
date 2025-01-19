//
//  KeyFrameAnimationExample.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2025/01/19.
//

import SwiftUI

struct AnimationValues: Equatable {
    var scale: CGFloat = 1.0
    var rotation: Angle = .zero
}

struct KeyFrameAnimationExample: View {
    let duration = 2.0
    @State var trigger: Bool = false
    var body: some View {
        Circle()
            .stroke(
                AngularGradient(
                    colors: [.red, .pink, .green, .yellow, .cyan, .purple, .red],
                    center: .center
                ),
                lineWidth: 20
            )
            .shadow(radius: 3)
            .frame(width: 300, height: 300)
            .padding()
            .keyframeAnimator(
                initialValue: AnimationValues(),
                trigger: trigger
            ) { view, value in
                view.scaleEffect(x: value.scale, y: value.scale)
                    .rotationEffect(value.rotation)
            } keyframes: { _ in
                KeyframeTrack(\.scale) {
                    LinearKeyframe(1.5, duration: 0.2 * duration)
                    SpringKeyframe(1.2, duration: 0.2 * duration)
                    LinearKeyframe(1.9, duration: 0.5 * duration)
                    LinearKeyframe(1.0, duration: 0.1 * duration)
                }

                KeyframeTrack(\.rotation) {
                    LinearKeyframe(
                        Angle(degrees: 180),
                        duration: 0.2 * duration
                    )
                    SpringKeyframe(Angle(degrees: -180), duration: 0.2 * duration)
                    LinearKeyframe(Angle(degrees: 360), duration: 0.5 * duration)
                    LinearKeyframe(Angle(degrees: 0), duration: 0.1 * duration)
                }
            }
            .onTapGesture {
                trigger.toggle()
            }
    }
}

#Preview {
    KeyFrameAnimationExample()
}
