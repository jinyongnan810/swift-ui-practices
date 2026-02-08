//
//  Complex3DAnimation.swift
//  SwiftUIPractices
//  Learning from Kavsoft: https://www.youtube.com/watch?v=XhgLm3T6BkU
//  Created by Yuunan kin on 2026/02/08.
//
//  Overview:
//  This file implements a 3D rotating animation effect where SF Symbol icons
//  orbit along a tilted elliptical path (a circle viewed in perspective).
//  A dashed circle and icons appear with a draw-in animation, then continuously
//  rotate forever. The effect is presented inside a half-sheet modal.
//

import SwiftUI

// MARK: - Main View

/// The entry point view that provides a toolbar button to present a sheet
/// containing the 3D rotation animation and a welcome message.
struct Complex3DAnimation: View {
    /// Controls whether the bottom sheet is presented
    @State var isPresented: Bool = false

    /// Reads the current color scheme (light/dark) to style the button accordingly
    @Environment(\.colorScheme) var colorScheme: ColorScheme

    var body: some View {
        Text("Click show sheet!")
            .navigationTitle(Text("Complex 3D Animation"))
            .toolbar {
                // Place a "Show Sheet" button on the trailing side of the navigation bar
                ToolbarItem(id: "sheet", placement: .primaryAction) {
                    Button {
                        isPresented.toggle()
                    } label: {
                        Text("Show Sheet")
                    }
                }
            }
            // Present a half-height sheet (.medium detent) with the animation content
            .sheet(isPresented: $isPresented) {
                VStack(alignment: .center) {
                    // The 3D rotating effect with 4 SF Symbol icons
                    Rotating3DEffectView(symbols: ["sun.max", "figure.walk", "network", "gamecontroller.fill"])
                        .frame(width: 300, height: 300)

                    Text("Welcome to the App!")
                        .font(.largeTitle)

                    // "Continue" button that dismisses the sheet.
                    // Colors are inverted based on the color scheme:
                    //   Light mode -> white text on black capsule
                    //   Dark mode  -> black text on white capsule
                    Button {
                        isPresented = false
                    } label: {
                        Text("Continue")
                            .frame(maxWidth: .infinity)
                            .foregroundStyle(
                                colorScheme != .dark ? .white : .black
                            )
                            .padding(.vertical, 10)
                            .background(
                                colorScheme == .dark ? .white : .black,
                                in: .capsule
                            )
                    }.padding()
                }.presentationDetents([.medium])
            }
    }
}

// MARK: - Rotating 3D Effect View

/// A wrapper view that owns the animation state (`trim` and `rotation`)
/// and kicks off the two-phase animation sequence when the view appears.
struct Rotating3DEffectView: View {
    /// Array of SF Symbol names to display as orbiting icons
    var symbols: [String]

    /// Controls how much of the dashed circle is drawn (0 = nothing, 1 = full circle).
    /// Also used to stagger the scale-in of each icon.
    @State var trim: CGFloat = 0

    /// The current rotation angle in radians. Animates from 0 to 2pi continuously.
    @State var rotation: CGFloat = 0

    var body: some View {
        // Use a transparent Rectangle as a sizing container.
        // The actual visuals are drawn by the modifier's overlay.
        Rectangle().foregroundStyle(.clear)
            .modifier(
                Rotating3DEffectModifier(
                    symbols: symbols,
                    trim: trim,
                    rotation: rotation
                )
            )
            .task {
                // --- Animation Sequence ---

                // Phase 0: Wait 0.1s for the view to fully appear on screen
                try? await Task.sleep(for: .seconds(0.1))

                // Phase 1: Draw-in animation (1.5s, ease-in-out)
                //   - The dashed circle draws from 0% to 100%
                //   - Each icon scales in sequentially as `trim` passes its threshold
                withAnimation(.easeInOut(duration: 1.5)) {
                    trim = 1
                }

                // Phase 2: Brief pause (0.5s) after the draw-in completes
                try? await Task.sleep(for: .seconds(0.5))

                // Phase 3: Start continuous rotation (one full revolution every 15s)
                //   - .repeatForever keeps it spinning indefinitely
                //   - autoreverses: false ensures it always rotates in the same direction
                withAnimation(
                    .linear(duration: 15).repeatForever(autoreverses: false)
                ) {
                    rotation = CGFloat.pi * 2
                }
            }
    }
}

// MARK: - Rotating 3D Effect Modifier

/// A custom ViewModifier that renders the dashed circle and orbiting icons.
///
/// The `@Animatable` macro makes `trim` and `rotation` interpolatable by
/// SwiftUI's animation system. On every animation frame, SwiftUI recalculates
/// intermediate values for these properties, producing smooth motion.
@Animatable
struct Rotating3DEffectModifier: ViewModifier {
    /// `@AnimatableIgnored` excludes `symbols` from animation interpolation
    /// (String arrays can't be interpolated between values).
    @AnimatableIgnored var symbols: [String]

    /// Current draw progress of the dashed circle (0.0 to 1.0) - animatable
    var trim: CGFloat

    /// Current rotation angle in radians (0 to 2pi) - animatable
    var rotation: CGFloat

    func body(content: Content) -> some View {
        content
            .overlay {
                GeometryReader { geo in
                    let size = geo.size

                    // Use the smaller dimension so the circle fits in a square region
                    let circleSize = min(size.width, size.height)

                    // Calculate the arc length of each dash segment.
                    // The circumference (pi x diameter) is divided by (symbolCount x 2)
                    // so we get `symbolCount` visible dashes separated by equal-length gaps.
                    let dashLength = CGFloat.pi * circleSize / CGFloat(
                        symbols.count * 2
                    )

                    let radius = circleSize / 2

                    ZStack {
                        // MARK: Dashed Circle (3D-tilted)

                        Circle()
                            // `trim` controls how much of the circle path is visible.
                            // Animating from 0 -> 1 creates the "drawing" effect.
                            .trim(from: 0, to: trim)
                            .stroke(
                                .primary,
                                style: .init(
                                    lineWidth: 3,
                                    // `dash`: alternating dash/gap pattern with equal lengths
                                    dash: [dashLength],
                                    // `dashPhase`: shifts the dash pattern so that dashes
                                    // are centered on each icon's position (offset by half a dash)
                                    dashPhase: -dashLength / 2
                                )
                            )
                            // 2D rotation around the Z-axis (the continuously animated spin)
                            .rotationEffect(.radians(rotation))
                            // Tilt the circle 60 degrees around the X-axis to create
                            // a 3D elliptical look.
                            // perspective: 0 uses orthographic (parallel) projection, so
                            // the far side of the circle isn't smaller than the near side.
                            .rotation3DEffect(
                                .degrees(60),
                                axis: (x: 1, y: 0, z: 0),
                                anchor: .center,
                                perspective: 0
                            )
                            // Rotate -25 degrees around the Z-axis to tilt the
                            // entire ellipse diagonally for a more dynamic appearance
                            .rotation3DEffect(.degrees(-25), axis: (x: 0, y: 0, z: 1), anchor: .center,
                                              perspective: 0)

                        // MARK: Orbiting SF Symbol Icons

                        ZStack {
                            ForEach(0 ..< symbols.count, id: \.self) { index in
                                // --- Position Calculation ---

                                // Base angle for this icon (evenly spaced around the circle)
                                // plus the current rotation offset for continuous orbiting.
                                // For 4 icons, they are placed at 0, 90, 180, 270 degrees apart.
                                let angle = (CGFloat.pi * 2 / CGFloat(symbols.count)) * CGFloat(
                                    index
                                ) + rotation

                                // The Y-axis compression factor from the 60-degree X-axis tilt.
                                // cos(60 degrees) = 0.5, so the vertical radius is halved,
                                // making the circular path appear as an ellipse when viewed
                                // from the front.
                                let rotation3d = cos((60 * CGFloat.pi) / 180)

                                // Compute the icon's position on the elliptical orbit:
                                //   x = horizontal position (full radius, standard cosine)
                                //   y = vertical position (compressed by cos(60) ~ 0.5)
                                let x = cos(angle) * radius
                                let y = sin(angle) * radius * rotation3d

                                // Per-icon Y-axis spin: combines the global rotation with
                                // an index-based offset (index * 2) so each icon has a
                                // slightly different facing angle, creating visual variety
                                // as they orbit (like a "billboard" or "card flip" effect).
                                let individualRotation = rotation + CGFloat(index * 2)

                                // --- Staggered Scale-In Animation ---
                                // Each icon scales from 0 -> 1 during its own portion of the
                                // trim animation. For 4 icons:
                                //   Icon 0: scales in while trim goes from 0.00 to 0.25
                                //   Icon 1: scales in while trim goes from 0.25 to 0.50
                                //   Icon 2: scales in while trim goes from 0.50 to 0.75
                                //   Icon 3: scales in while trim goes from 0.75 to 1.00
                                let animationStart = CGFloat(index) / CGFloat(symbols.count)
                                let animationEnd = (CGFloat(index) + 1) / CGFloat(symbols.count)
                                // Clamp the progress value between 0 and 1
                                let scalingProgress = min(
                                    max((trim - animationStart) / (animationEnd - animationStart), 0), 1
                                )

                                Image(systemName: symbols[index])
                                    .font(.title)
                                    // Two layered shadows for a soft, elevated appearance:
                                    //   - Inner shadow: tight, subtle
                                    //   - Outer shadow: larger, softer spread
                                    .shadow(
                                        color: .primary.opacity(0.15),
                                        radius: 2,
                                        x: 1,
                                        y: 2
                                    )
                                    .shadow(
                                        color: .primary.opacity(0.1),
                                        radius: 9,
                                        x: 5,
                                        y: 8
                                    )
                                    // Scale from 0 to 1 based on the staggered progress,
                                    // so icons "pop in" one after another during the draw-in
                                    .scaleEffect(scalingProgress)
                                    // Spin each icon around its own Y-axis, creating a
                                    // "card flip" effect as it orbits around the ellipse
                                    .rotation3DEffect(
                                        .radians(individualRotation),
                                        axis: (x: 0, y: 1, z: 0),
                                        anchor: .center,
                                        perspective: 0
                                    )
                                    // Slight 20-degree tilt to complement the overall
                                    // -25-degree Z rotation applied to the parent ZStack
                                    .rotationEffect(.init(degrees: 20))
                                    // Position the icon at its calculated orbit coordinates
                                    .offset(x: x, y: y)
                            }
                        }
                        // Rotate the entire icon group -25 degrees to match the
                        // dashed circle's diagonal tilt, so icons visually sit
                        // on top of the dashed ellipse path
                        .rotationEffect(.init(degrees: -25))
                    }
                }
            }
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        Complex3DAnimation()
        // Rotating3DEffectView(symbols: ["sun.max", "figure.walk", "network", "gamecontroller.fill"])
    }
}
