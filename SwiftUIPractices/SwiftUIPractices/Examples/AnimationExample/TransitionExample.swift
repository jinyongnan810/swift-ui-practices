//
//  TransitionExample.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2025/12/27.
//

import SwiftUI

struct TransitionItem: View {
    var body: some View {
        ZStack {
            Circle()
                .foregroundStyle(.cyan.gradient)
                .frame(width: 100, height: 100)
                .padding()
            Text("Hello").font(.largeTitle)
        }
    }
}

struct WrapWithSpacer: ViewModifier {
    var isPresented: Bool
    func body(content: Content) -> some View {
        HStack(alignment: .center) {
            Spacer()
            if isPresented {
                content
            }
            Spacer()
        }.frame(height: 130)
    }
}

extension View {
    func wrapWithSpacer(_ isPresented: Bool) -> some View {
        modifier(WrapWithSpacer(isPresented: isPresented))
    }
}

extension AnyTransition {
    static var rotateWithScale: AnyTransition {
        AnyTransition
            .modifier(
                active: RotateScaleModifier(
                    rotation: 360.0,
                    scale: 0.4,
                    opacity: 0.1,
                    blur: 10
                ),
                identity: RotateScaleModifier(
                    rotation: 0,
                    scale: 1,
                    opacity: 1,
                    blur: 0
                )
            )
    }
}

struct RotateScaleModifier: ViewModifier {
    let rotation: Double
    let scale: CGFloat
    let opacity: Double
    let blur: CGFloat
    func body(content: Content) -> some View {
        content.rotation3DEffect(.degrees(rotation), axis: (x: 0, y: 1, z: 0))
            .scaleEffect(scale)
            .opacity(opacity)
            .blur(radius: blur)
    }
}

struct BackgroundView: View {
    var body: some View {
        MeshGradient(
            width: 2,
            height: 2,
            points: [
                [0, 0], [1, 0],
                [0, 1], [1, 1],
            ],
            colors: [
                .pink, .indigo,
                .cyan, .red,
            ]
        )
        .opacity(0.4)
        .ignoresSafeArea()
    }
}

struct TransitionExample: View {
    @State private var isPresented: Bool = false
    var body: some View {
        ZStack {
            BackgroundView()

            VStack {// this fails when replaced with List
                Section("Single Transition") {
                    TransitionItem()
                        .transition(.move(edge: .bottom))
                        .wrapWithSpacer(isPresented)
                        .clipped()
                }
                Section("Asymmetric Transition") {
                    TransitionItem()
                        .transition(
                            .asymmetric(insertion: .slide, removal: .opacity)
                        )
                        .wrapWithSpacer(isPresented)
                }
                Section("Combined Transition") {
                    TransitionItem()
                        .transition(
                            .move(edge: .trailing)
                                .combined(with: .scale)
                                .combined(with: .opacity)
                        )
                        .wrapWithSpacer(isPresented)
                }
                Section("Custom Transition") {
                    TransitionItem()
                        .transition(
                            .rotateWithScale
                        )
                        .wrapWithSpacer(isPresented)
                }
            }
        }.onTapGesture {
            withAnimation {
                isPresented.toggle()
            }
        }
    }
}

#Preview {
    TransitionExample()
}
