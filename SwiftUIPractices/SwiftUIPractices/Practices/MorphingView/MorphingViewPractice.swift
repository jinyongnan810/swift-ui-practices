//
//  MorphingViewPractice.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2026/05/24.
//

import SwiftUI

/// A small two-state wrapper that shows either `from` or `to`.
/// The visible child changes with an opacity transition, then `MorphingModifier`
/// post-processes the result with blur and a Metal alpha cutoff.
struct MorphingView<From: View, To: View>: View {
    var isToViewVisible: Bool
    @ViewBuilder var from: From
    @ViewBuilder var to: To

    var body: some View {
        ZStack {
            // Only one child is mounted at a time so SwiftUI can drive
            // insertion/removal through the view transition system.
            if !isToViewVisible {
                from.contentTransition(.identity)
                    .transition(.opacity)
            }

            if isToViewVisible {
                to.contentTransition(.identity)
                    .transition(.opacity)
            }
        }
        .modifier(MorphingModifier(progress: isToViewVisible ? 1 : 0))
    }
}

/// Animates a temporary blur around the midpoint of the transition and runs the
/// composited layer through `MorphingOpacityCutoff` in Metal.
@Animatable
struct MorphingModifier: ViewModifier {
    var progress: CGFloat

    // This constant should not be interpolated as part of the modifier's
    // animatable state; only `progress` drives the transition.
    @AnimatableIgnored let blurRadius: CGFloat = 15

    func body(content: Content) -> some View {
        content.compositingGroup().blur(radius: blurProgress * blurRadius)
            .visualEffect { view, proxy in
                view.layerEffect(
                    ShaderLibrary.MorphingOpacityCutoff(),
                    // Blur can sample outside the original pixel, so allow the
                    // shader to read across the whole rendered view bounds.
                    maxSampleOffset: proxy.size
                )
            }
    }

    private var blurProgress: CGFloat {
        // Ramps 0 -> 0.5 -> 0 over the transition, peaking when both views are
        // equally represented by the opacity transition.
        progress >= 0.5 ? abs(1 - progress) : progress
    }
}

struct MorphingViewPractice: View {
    @State private var isToViewVisible = false

    // The wrapper alternates between these two endpoints. Tapping a new icon
    // replaces the hidden endpoint, then toggles which endpoint is visible.
    @State private var fromSystemImage = "heart.fill"
    @State private var toSystemImage = "heart.fill"

    private let icons = [
        "heart.fill",
        "star.fill",
        "bell.fill",
        "bolt.fill",
        "flame.fill",
        "moon.fill",
        "cloud.fill",
        "paperplane.fill",
        "bookmark.fill",
        "shield.fill",
    ]

    var body: some View {
        VStack(spacing: 36) {
            MorphingView(isToViewVisible: isToViewVisible) {
                morphIcon(fromSystemImage)
            } to: {
                morphIcon(toSystemImage)
            }
            .frame(width: 260, height: 260)

            ScrollView(.horizontal) {
                HStack(spacing: 14) {
                    ForEach(icons, id: \.self) { icon in
                        Button {
                            select(icon)
                        } label: {
                            Image(systemName: icon)
                                .font(.system(size: 24, weight: .semibold))
                                .foregroundStyle(selectedIcon == icon ? .white : .primary)
                                .frame(width: 56, height: 56)
                                .background(
                                    selectedIcon == icon ? .blue : .gray.opacity(0.14),
                                    in: Circle()
                                )
                        }
                        .buttonStyle(.plain)
                        .accessibilityLabel(icon)
                    }
                }
                .padding(.horizontal)
            }
            .scrollIndicators(.hidden)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
        .navigationTitle("Morphing View")
    }

    private var selectedIcon: String {
        // Keeps the icon list highlight in sync with the currently visible side.
        isToViewVisible ? toSystemImage : fromSystemImage
    }

    private func morphIcon(_ systemImage: String) -> some View {
        Image(systemName: systemImage)
            .font(.system(size: 148, weight: .semibold))
            .foregroundStyle(.blue.gradient)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private func select(_ systemImage: String) {
        withAnimation(
            .interpolatingSpring(duration: 0.68, bounce: 0, initialVelocity: 0)
        ) {
            // Update the hidden endpoint first. The subsequent toggle makes it
            // the destination for the next opacity transition.
            if isToViewVisible {
                fromSystemImage = systemImage
            } else {
                toSystemImage = systemImage
            }
            isToViewVisible.toggle()
        }
    }
}

#Preview {
    NavigationStack {
        MorphingViewPractice()
    }
}
