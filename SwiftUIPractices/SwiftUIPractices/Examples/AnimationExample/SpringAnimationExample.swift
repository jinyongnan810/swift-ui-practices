//
//  SpringAnimationExample.swift
//  SwiftUIPractices
//

import SwiftUI

struct SpringAnimationExample: View {
    @State private var selectedModel = SpringModel.perceptual
    @State private var isAtEnd = false

    @State private var duration = 0.7
    @State private var bounce = 0.35
    @State private var response = 0.5
    @State private var dampingFraction = 0.7
    @State private var blendDuration = 0.0

    @State private var mass = 1.0
    @State private var stiffness = 170.0
    @State private var damping = 15.0
    @State private var initialVelocity = 0.0

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                Text("A spring animation moves toward a target using spring physics. Change one value at a time to see what each property controls.")
                    .foregroundStyle(.secondary)

                Picker("Spring model", selection: $selectedModel) {
                    ForEach(SpringModel.allCases) { model in
                        Text(model.title).tag(model)
                    }
                }
                .pickerStyle(.segmented)
                .onChange(of: selectedModel) {
                    isAtEnd = false
                }

                selectionTip

                springPreview

                VStack(spacing: 20) {
                    switch selectedModel {
                    case .perceptual:
                        parameterSlider(
                            title: "Duration",
                            value: $duration,
                            range: 0.1 ... 2.0,
                            format: "%.2f s",
                            explanation: "The perceived pace of the spring. Lower values feel faster; higher values feel slower."
                        )
                        parameterSlider(
                            title: "Bounce",
                            value: $bounce,
                            range: -0.5 ... 1.0,
                            format: "%.2f",
                            explanation: "Controls overshoot. Zero is critically damped, positive values bounce, and negative values are overdamped."
                        )
                        blendDurationSlider

                    case .response:
                        parameterSlider(
                            title: "Response",
                            value: $response,
                            range: 0.1 ... 2.0,
                            format: "%.2f s",
                            explanation: "An approximate duration that represents spring stiffness. A smaller response produces a faster, stiffer spring."
                        )
                        parameterSlider(
                            title: "Damping Fraction",
                            value: $dampingFraction,
                            range: 0.1 ... 1.5,
                            format: "%.2f",
                            explanation: "The drag relative to critical damping. Values below 1 bounce; 1 settles without bouncing; values above 1 are overdamped."
                        )
                        blendDurationSlider

                    case .physical:
                        parameterSlider(
                            title: "Mass",
                            value: $mass,
                            range: 0.1 ... 5.0,
                            format: "%.2f",
                            explanation: "The weight attached to the spring. More mass generally accelerates and settles more slowly."
                        )
                        parameterSlider(
                            title: "Stiffness",
                            value: $stiffness,
                            range: 10 ... 500,
                            format: "%.0f",
                            explanation: "The spring force. Higher stiffness pulls toward the target more strongly and quickly."
                        )
                        parameterSlider(
                            title: "Damping",
                            value: $damping,
                            range: 0 ... 50,
                            format: "%.1f",
                            explanation: "Friction that removes energy. Low damping oscillates longer; high damping suppresses bounce."
                        )
                        parameterSlider(
                            title: "Initial Velocity",
                            value: $initialVelocity,
                            range: -5 ... 5,
                            format: "%.1f",
                            explanation: "The velocity at the moment the animation starts, expressed relative to the total animated distance."
                        )
                    }
                }

                Button("Reset Values", action: resetValues)
                    .buttonStyle(.bordered)
                    .frame(maxWidth: .infinity)
            }
            .padding()
        }
        .navigationTitle("Spring Properties")
    }

    private var selectionTip: some View {
        VStack(alignment: .leading, spacing: 8) {
            Label("When to choose this", systemImage: "lightbulb.fill")
                .font(.headline)
                .foregroundStyle(.orange)

            Text(selectedModel.selectionTip)
                .font(.subheadline)

            Text(selectedModel.examples)
                .font(.footnote)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(.orange.opacity(0.1), in: RoundedRectangle(cornerRadius: 12))
    }

    private var springPreview: some View {
        VStack(alignment: .leading, spacing: 12) {
            GeometryReader { geometry in
                let travel = max(geometry.size.width - 52, 0)

                ZStack(alignment: .leading) {
                    Capsule()
                        .fill(.quaternary)
                        .frame(height: 6)

                    Circle()
                        .fill(.blue.gradient)
                        .frame(width: 52, height: 52)
                        .shadow(color: .blue.opacity(0.3), radius: 8, y: 4)
                        .offset(x: isAtEnd ? travel : 0)
                }
                .frame(maxHeight: .infinity)
            }
            .frame(height: 60)

            Button(isAtEnd ? "Animate Back" : "Animate") {
                withAnimation(animation) {
                    isAtEnd.toggle()
                }
            }
            .buttonStyle(.borderedProminent)
            .frame(maxWidth: .infinity)
        }
        .padding()
        .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 16))
    }

    private var animation: Animation {
        switch selectedModel {
        case .perceptual:
            .spring(
                duration: duration,
                bounce: bounce,
                blendDuration: blendDuration
            )
        case .response:
            .spring(
                response: response,
                dampingFraction: dampingFraction,
                blendDuration: blendDuration
            )
        case .physical:
            .interpolatingSpring(
                mass: mass,
                stiffness: stiffness,
                damping: damping,
                initialVelocity: initialVelocity
            )
        }
    }

    private var blendDurationSlider: some View {
        parameterSlider(
            title: "Blend Duration",
            value: $blendDuration,
            range: 0 ... 1.0,
            format: "%.2f s",
            explanation: "How long SwiftUI blends parameter changes when one spring replaces another while motion is already in progress."
        )
    }

    private func parameterSlider(
        title: String,
        value: Binding<Double>,
        range: ClosedRange<Double>,
        format: String,
        explanation: String
    ) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(title)
                    .font(.headline)
                Spacer()
                Text(String(format: format, value.wrappedValue))
                    .monospacedDigit()
                    .foregroundStyle(.secondary)
            }

            Slider(value: value, in: range)

            Text(explanation)
                .font(.footnote)
                .foregroundStyle(.secondary)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding()
        .background(.background.secondary, in: RoundedRectangle(cornerRadius: 12))
    }

    private func resetValues() {
        isAtEnd = false
        duration = 0.7
        bounce = 0.35
        response = 0.5
        dampingFraction = 0.7
        blendDuration = 0.0
        mass = 1.0
        stiffness = 170.0
        damping = 15.0
        initialVelocity = 0.0
    }
}

private enum SpringModel: String, CaseIterable, Identifiable {
    case perceptual
    case response
    case physical

    var id: Self { self }

    var title: String {
        switch self {
        case .perceptual:
            "Simple"
        case .response:
            "Response"
        case .physical:
            "Physics"
        }
    }

    var selectionTip: String {
        switch self {
        case .perceptual:
            "Use this as the default for most interface motion. Duration and bounce map directly to how people usually describe an animation, making it quick to tune."
        case .response:
            "Use this when working with existing response-based springs or when you want to reason about underdamped, critically damped, and overdamped motion."
        case .physical:
            "Use this for simulations and gesture-driven motion where mass, spring force, friction, or incoming velocity need an explicit physical meaning."
        }
    }

    var examples: String {
        switch self {
        case .perceptual:
            "Good for: buttons, cards, sheets, navigation changes, and selection feedback."
        case .response:
            "Good for: matching an established motion system and precisely controlling settling behavior."
        case .physical:
            "Good for: drag releases, momentum handoffs, games, and physics-based interactions."
        }
    }
}

#Preview {
    NavigationStack {
        SpringAnimationExample()
    }
}
