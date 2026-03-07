//
//  AppIntroductionView.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2026/02/25.
//  Learning from Kavsoft: https://youtu.be/IoLPClPxgsY?si=NuGocVZTQhVIhpEO
//

import SwiftUI

private struct IntroductionItem {
    var id: Int
    var title: String
    var description: String
    var screenshot: UIImage
    var zoomScale: CGFloat = 1
    var zoomAnchor: UnitPoint = .center
}

struct AppIntroductionView: View {
    @State private var currentIndex: Int = 0
    // Pitfall: this starts as .zero; guard zero when using it in max frame constraints.
    @State private var screenshotSize: CGSize = .zero
    let animation: Animation = .interpolatingSpring(
        duration: 0.6,
        bounce: 0,
        initialVelocity: 0
    )
    fileprivate let items: [IntroductionItem] = [
        .init(
            id: 1,
            title: "Explore SwiftUI Feature Demos",
            description: "Browse concise examples for navigation, animation, effects, and more.",
            screenshot: UIImage(named: "screen1")!
        ),
        .init(
            id: 2,
            title: "Animated SF Symbols",
            description: "Learn symbol effects like bounce, pulse, transition, and repeat controls.",
            screenshot: UIImage(named: "screen2")!,
            zoomScale: 1.3,
            zoomAnchor: .top
        ),
        .init(
            id: 3,
            title: "Interactive 3D Motion",
            description: "Build richer onboarding with layered movement and perspective-based animation.",
            screenshot: UIImage(named: "screen3")!,
            zoomScale: 1.5,
            zoomAnchor: .bottom
        ),
        .init(
            id: 4,
            title: "Creative Shape Composition",
            description: "Experiment with clipping and custom shapes to craft expressive visual layouts.",
            screenshot: UIImage(named: "screen4")!,
            zoomScale: 1.4,
            zoomAnchor: .center
        ),
        .init(
            id: 5,
            title: "Chocolate UI Practice",
            description: "Try a playful themed screen with gradients, typography, and visual rhythm.",
            screenshot: UIImage(named: "screen5")!
        ),
    ]
    var deviceCornerRadius: CGFloat {
        if let imageSize = items.first?.screenshot.size {
            let ratio = screenshotSize.height / imageSize.height
            let basic: CGFloat = 190
            return basic * ratio
        }
        return 0
    }

    @ViewBuilder
    // Advances the onboarding flow to the next page.
    func continueButton() -> some View {
        Button {
            withAnimation(animation) {
                currentIndex = min(currentIndex + 1, items.count - 1)
            }
            print("currentIndex: \(currentIndex)")
        } label: {
            Text(currentIndex == items.count - 1 ? "Get Started" : "Continue")
                .fontWeight(.medium)
                .padding(.vertical, 5)
                // Make text transition like number flips
                .contentTransition(.numericText())
        }.buttonStyle(.glassProminent)
            .buttonSizing(.flexible)
            .padding(.horizontal, 30)
    }

    @ViewBuilder
    // Moves the onboarding flow to the previous page.
    func backButton() -> some View {
        Button {
            withAnimation(animation) {
                currentIndex = max(currentIndex - 1, 0)
            }
            print("currentIndex: \(currentIndex)")
        } label: {
            Image(systemName: "chevron.left")
                .padding(5)
        }.buttonStyle(.glass)
            .buttonBorderShape(.circle)
    }

    @ViewBuilder
    // Renders page indicators that reflect the current index.
    func indicators() -> some View {
        HStack(spacing: 5) {
            ForEach(0 ..< items.count, id: \.self) { index in
                let isActive = index == currentIndex
                Capsule()
                    .fill(isActive ? Color.white : Color.gray)
                    .frame(width: isActive ? 15 : 5, height: 5)
            }
        }
    }

    @ViewBuilder
    // Displays title/description pages synced with currentIndex.
    func introductionTexts() -> some View {
        GeometryReader { geo in
            ScrollView(.horizontal) {
                HStack(spacing: 0) {
                    ForEach(items.indices, id: \.self) { index in
                        let item = items[index]
                        let isActive = index == currentIndex
                        VStack {
                            Text(item.title)
                                .font(.title2)
                                .bold()
                                .lineLimit(1)
                            Text(item.description)
                                .font(.callout)
                                .lineLimit(2)
                                .multilineTextAlignment(.center)
                        }
                        .frame(width: geo.size.width)
                        .id(index)
                        .compositingGroup()
                        .blur(radius: isActive ? 0 : 10)
                        .opacity(isActive ? 1 : 0)
                    }
                }
                // Advanced: marks each child as a paging target for scrollPosition(id:).
                .scrollTargetLayout()
            }.scrollDisabled(true)
                .scrollTargetBehavior(.paging)
                .scrollIndicators(.hidden)
                .scrollPosition(id: .init(get: {
                    currentIndex
                }, set: { _ in
                    // Programmatic-only carousel: ignore user-driven writebacks.
                }))
        }
    }

    @ViewBuilder
    // Provides a background glass/blur effect behind the bottom content area.
    func blurEffect() -> some View {
        let radius: CGFloat = 15
        Rectangle()
            .fill(.clear)
            .glassEffect(.clear.tint(.black.opacity(0.5)), in: .rect)
            .blur(radius: radius)
            .padding([.horizontal, .bottom], -radius * 2)
            .padding(.top, -radius / 2)
            .opacity(items[currentIndex].zoomScale != 1 ? 1 : 0)
            .ignoresSafeArea()
    }

    @ViewBuilder
    // Displays screenshot pages synced with currentIndex.
    func introductionImages() -> some View {
        let shape = ConcentricRectangle(corners: .concentric, isUniform: true)
        GeometryReader { geo in
            let size = geo.size
            ScrollView(.horizontal) {
                HStack(spacing: 0) {
                    ForEach(items.indices, id: \.self) { index in
                        let item = items[index]
                        Image(uiImage: item.screenshot)
                            .resizable()
                            .scaledToFit()
                            // Advanced: capture rendered size after layout to derive bezel/corner metrics.
                            .onGeometryChange(for: CGSize.self, of: { geo in
                                geo.size
                            }, action: { newValue in
                                screenshotSize = newValue
                                print("set size: \(newValue)")
                            })
                            .clipShape(
                                shape
                            )

                            .frame(
                                width: size.width,
                                height: size.height
                            )
                            .id(index)
                    }
                    // Required with paging + id-based positioning so each page can snap precisely.
                    .scrollTargetLayout()
                }
            }
            .scrollDisabled(true)
            .scrollTargetBehavior(.paging)
            .scrollIndicators(.hidden)
            .scrollPosition(id: .init(get: {
                currentIndex
            }, set: { _ in
                // Programmatic-only carousel: ignore user-driven writebacks.
            }))
        }
        .clipShape(shape)
        .overlay {
            ZStack {
                shape.stroke(.white, lineWidth: 6)
                shape.stroke(.black, lineWidth: 4)
                shape.stroke(.black, lineWidth: 6)
                    .padding(4)
            }.padding(-6)
        }
        .frame(
            // Pitfall: maxWidth/maxHeight of 0 collapses GeometryReader content.
            // Keep nil until the first non-zero measurement arrives.
            maxWidth: screenshotSize == .zero ? nil : screenshotSize.width,
            maxHeight: screenshotSize == .zero ? nil : screenshotSize.height
        )
        .containerShape(
            RoundedRectangle(
                cornerRadius: deviceCornerRadius
            )
        )
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    // Main layout that composes images, text, controls, and overlayed back button.
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                introductionImages()
                    .compositingGroup()
                    .scaleEffect(
                        items[currentIndex].zoomScale,
                        anchor: items[currentIndex].zoomAnchor
                    )
                VStack(spacing: 10) {
                    introductionTexts()
                    indicators()
                    continueButton()
                }.frame(height: 150)
                    .background {
                        blurEffect()
                    }
                    .padding(.top, 15)
            }
        }
        .overlay(alignment: .topLeading) {
            // Pitfall: keep this above ScrollView layers; otherwise they can swallow button taps.
            backButton()
        }
        .padding()
        .preferredColorScheme(.dark)
    }
}

#Preview {
    AppIntroductionView()
}
