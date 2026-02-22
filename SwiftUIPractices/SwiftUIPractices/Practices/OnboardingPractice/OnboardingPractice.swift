//
//  OnboardingPractice.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2026/02/18.
//  Learning from Kavsoft: https://youtu.be/WqzDYtc7yjA?si=BPQlZ_9TMbpftKYy
//

import SwiftUI

// Holds all mutable animation state that drives the multi-step onboarding sequence.
// Each property is toggled/mutated in order inside a Task to create a choreographed animation.
private struct OnboardingAnimationProperties {
    var animateMainCircle: Bool = false // Triggers the main circle's scale-in (0 → full size)
    var subCirclesSize: CGFloat = 50 // Diameter of each orbiting sub-circle
    var subCirclesOffset: CGFloat = 0 // How far sub-circles travel outward from the center
    var subCirclesScale: CGFloat = 0 // Scale multiplier; 0 = hidden, 1 = visible
    var subCirclesTakePosition: Bool = false // Snaps sub-circles to their final orbital positions
    var circleStrokeTrim: CGFloat = 0 // Controls stroke-draw progress (0 → 1 = full circle)
    var animateGridLines: Bool = false // Reveals the grid overlay lines
    var convertToLogo: Bool = false // Fades in the SF Symbol logo icon
    var finishingAnimations: Bool = false // Shrinks the canvas to a small card and shows the title
}

struct OnboardingPractice: View {
    let tint = Color.blue
    let icon = "swift"
    @State private var animationProperties: OnboardingAnimationProperties = .init()
    var body: some View {
        ZStack {
            // Title text sits below the animated canvas; only appears after the sequence completes
            VStack {
                Text("Welcome to SwiftUI")
            }.offset(y: 140)
                .opacity(animationProperties.finishingAnimations ? 1 : 0)

            OnboardingView()
        }
        .padding()
    }

    // The main animated canvas. GeometryReader is used to derive a square size from the
    // available space so the animation fills the screen during the sequence, then collapses
    // to a small card (200×200) when finishingAnimations is true.
    @ViewBuilder
    func OnboardingView() -> some View {
        GeometryReader { geo in
            // Use the smaller dimension so the canvas stays square on any device
            let size = min(geo.size.width, geo.size.height)
            ZStack {
                // Background gradient circle — scales from 0 to 2× to fill the canvas
                Circle()
                    .fill(tint.gradient)
                    .scaleEffect(animationProperties.animateMainCircle ? 2 : 0)

                // Intermediate animation elements: hidden once the logo appears
                Group {
                    Circles() // Four orbiting white dots
                    CircleStrokes() // Four stroke circles that draw themselves in
                    GridLines() // Grid overlay (vertical, horizontal, and diagonal lines)
                }.opacity(animationProperties.finishingAnimations ? 0 : 1)

                // SF Symbol logo; fades and un-blurs into view after the grid animation
                Image(systemName: icon)
                    .font(.system(size: 100))
                    .foregroundColor(.white)
                    .opacity(animationProperties.convertToLogo ? 1 : 0)
                    .blur(radius: animationProperties.convertToLogo ? 0 : 10)
            }
            // Shrink to card size when the finishing phase begins
            .frame(
                width: animationProperties.finishingAnimations ? 200 : size,
                height: animationProperties.finishingAnimations ? 200 : size,
                alignment: .center
            )
            .clipShape(.rect(cornerRadius: 30))
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }.onAppear {
            // Guard prevents re-running the sequence if the view re-appears
            guard !animationProperties.animateMainCircle else { return }

            // Each `await delayAnimation` call suspends until the previous animation finishes,
            // creating a sequential, choreographed timeline without nested callbacks.
            Task {
                // 1. Expand the background circle to fill the canvas
                await delayAnimation(0.1, .easeInOut(duration: 0.5), perform: {
                    animationProperties.animateMainCircle = true
                })
                // 2. Pop the four sub-circles into view with a bouncy spring
                await delayAnimation(0.1, .bouncy(duration: 0.6, extraBounce: 0.2), perform: {
                    animationProperties.subCirclesScale = 1
                })
                // 3. Push the sub-circles outward from the center
                await delayAnimation(0.3, .bouncy(duration: 0.5), perform: {
                    animationProperties.subCirclesOffset = 50
                })
                // 4. Shrink the sub-circles to tiny dots before snapping to final positions
                await delayAnimation(0.1, .bouncy(duration: 0.4), perform: {
                    animationProperties.subCirclesSize = 5
                })
                // 5. Snap sub-circles to their staggered orbital positions
                await delayAnimation(0.2, .linear(duration: 0.2), perform: {
                    animationProperties.subCirclesTakePosition = true
                })
                // 6. Fade the sub-circles out before the stroke rings appear
                await delayAnimation(0.2, .linear(duration: 0.2), perform: {
                    animationProperties.subCirclesScale = 0
                })
                // 7. Draw four stroke circles (trim 0 → 1)
                await delayAnimation(0, .linear(duration: 1), perform: {
                    animationProperties.circleStrokeTrim = 1
                })
                // 8. Reveal the grid lines
                await delayAnimation(0.2, .linear(duration: 1), perform: {
                    animationProperties.animateGridLines = true
                })
                // 9. Fade the SF Symbol logo in with a bouncy spring
                await delayAnimation(0.4, .bouncy(duration: 0.8), perform: {
                    animationProperties.convertToLogo = true
                })
                // 10. Collapse the canvas to a card and reveal the welcome title
                await delayAnimation(0.7, .easeOut(duration: 0.6), perform: {
                    animationProperties.finishingAnimations = true
                })
            }
        }
    }

    // Four white dots evenly spaced at 90° increments around the center.
    // Each dot travels outward, shrinks, and then snaps to a slightly staggered
    // orbital position before being scaled to zero.
    @ViewBuilder
    func Circles() -> some View {
        ZStack {
            ForEach(1 ... 4, id: \.self) { i in
                // Base rotation places dots at N/E/S/W; extraRotation tilts them when snapping
                let rotation: Double = 90 * Double(i)
                let extraRotation: Double = animationProperties.subCirclesTakePosition ? 20 : 0

                // Even-indexed dots sit farther out, odd ones closer, creating visual variety
                let extraOffset: CGFloat = i % 2 == 0 ? 40 : -20

                Circle()
                    .fill(.white)
                    .frame(width: animationProperties.subCirclesSize)
                    .scaleEffect(animationProperties.subCirclesScale)
                    .offset(
                        x: 0,
                        y: animationProperties.subCirclesTakePosition
                            ? (90 + extraOffset) // Final staggered orbit position
                            : animationProperties.subCirclesOffset // Moving outward phase
                    )
                    .rotationEffect(.degrees(CGFloat(rotation + extraRotation)))
            }
        }.compositingGroup() // Render all circles as one layer so opacity applies uniformly
    }

    // Four concentric stroke circles that draw themselves in via `.trim`.
    // Alternating sizes (140/260 pt) and 90° rotations give depth and asymmetry.
    @ViewBuilder
    func CircleStrokes() -> some View {
        ZStack {
            ForEach(1 ... 4, id: \.self) { i in
                // Alternate between a smaller inner ring and a larger outer ring
                let width: CGFloat = i % 2 == 0 ? 140 : 260
                let rotation: Double = 90 * Double(i)
                let extraRotation: Double = 20 // Additional tilt so rings look hand-drawn

                Circle()
                    .trim(from: 0, to: animationProperties.circleStrokeTrim) // Draws 0% → 100%
                    .stroke(.white, style: StrokeStyle(lineWidth: 1))
                    .frame(width: width)
                    .rotationEffect(.degrees(CGFloat(rotation + extraRotation)))
            }
        }.compositingGroup()
    }

    // Renders a semi-transparent grid of vertical, horizontal, and two diagonal lines.
    // Lines animate from zero length to full size when `animateGridLines` becomes true.
    // `scaleEffect(i % 2 == 0 ? 1 : -1)` mirrors alternate lines so they grow from
    // opposite ends, giving a "drawing in from both sides" effect.
    @ViewBuilder
    func GridLines() -> some View {
        ZStack {
            // Vertical lines spaced evenly via HStack
            HStack {
                ForEach(1 ... 5, id: \.self) { i in
                    Rectangle()
                        .fill(.white.tertiary)
                        .frame(
                            width: 1,
                            height: animationProperties.animateGridLines ? nil : 0 // nil = fill available
                        )
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                        .scaleEffect(i % 2 == 0 ? 1 : -1) // Mirror every other line's grow direction
                }
            }

            // Horizontal lines spaced evenly via VStack
            VStack {
                ForEach(1 ... 5, id: \.self) { i in
                    Rectangle()
                        .fill(.white.tertiary)
                        .frame(
                            width: animationProperties.animateGridLines ? nil : 0, // nil = fill available
                            height: 1
                        )
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                        .scaleEffect(i % 2 == 0 ? 1 : -1)
                }
            }

            // Diagonal line at 45° (top-left → bottom-right)
            Rectangle()
                .fill(.white.tertiary)
                .frame(
                    width: animationProperties.animateGridLines ? nil : 0,
                    height: 1
                )
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                .rotationEffect(.degrees(45))
                .padding(-100) // Extend beyond bounds so the rotated line spans the full canvas

            // Diagonal line at 135° (top-right → bottom-left)
            Rectangle()
                .fill(.white.tertiary)
                .frame(
                    width: animationProperties.animateGridLines ? nil : 0,
                    height: 1
                )
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                .rotationEffect(.degrees(135))
                .padding(-100)

        }.compositingGroup()
    }

    // Helper that suspends the calling Task for `delay` seconds, then runs a SwiftUI
    // animation. Using `async/await` here lets the caller chain multiple animations
    // sequentially without nesting or callback pyramids. The optional `completion`
    // closure fires when the animation finishes (SwiftUI 5.1+).
    func delayAnimation(
        _ delay: Double,
        _ animation: Animation,
        perform action: @escaping () -> Void,
        onComplete completion: (@escaping () -> Void) = {}
    ) async {
        try? await Task.sleep(for: .seconds(delay))
        withAnimation(animation) {
            action()
        } completion: {
            completion()
        }
    }
}

#Preview {
    OnboardingPractice()
}
