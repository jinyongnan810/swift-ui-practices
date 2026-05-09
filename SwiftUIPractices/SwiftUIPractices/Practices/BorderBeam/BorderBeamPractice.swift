//
//  BorderBeamPractice.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2026/05/10.
//  Learned from Kavsoft: https://youtu.be/DHqLSjgBNPY
//

import SwiftUI

// MARK: - BorderBeamEffect

private struct BorderBeamEffect: ViewModifier {
    var borderColor: Color
    var beamColors: [Color]
    var beamEnabled: Bool
    var gradientBeamEnabled: Bool
    var cornerRadius: CGFloat
    var rotationDuration: TimeInterval = 6.0

    func body(content: Content) -> some View {
        content
            .overlay(alignment: .center) {
                TimelineView(.animation) { timeline in
                    let t = timeline.date.timeIntervalSinceReferenceDate
                    let progress = (t.remainder(dividingBy: rotationDuration)) / rotationDuration
                    let angle = Angle(degrees: progress * 360)

                    // Shared angular gradient sweep used by parts 2 and 3
                    let sweep = AngularGradient(
                        gradient: Gradient(colors: [.clear, borderColor, .clear]),
                        center: .center,
                        startAngle: angle,
                        endAngle: angle + .degrees(100)
                    )

                    ZStack {
                        // 1) Base tertiary border
                        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                            .stroke(borderColor.tertiary, lineWidth: 1)

                        // 2) Animated angular gradient stroke around the border
                        if beamEnabled {
                            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                                .stroke(sweep, lineWidth: 0.6)
                        }

                        // 3) Beam gradient ring masked by the same sweep from (2)
                        if gradientBeamEnabled {
                            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                                .fill(
                                    LinearGradient(
                                        gradient: Gradient(colors: beamColors),
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                                        .blur(radius: 12)
                                        .blendMode(.destinationOut)
                                )
                                .compositingGroup()
                                .mask(sweep.blur(radius: 6).padding(-24))
                        }
                    }
                }
            }
    }
}

private extension View {
    func borderBeamEffect(
        borderColor: Color = .gray,
        beamColors: [Color] = [
            .white.opacity(0.0),
            .white.opacity(0.9),
            .white.opacity(0.0),
        ],
        beamEnabled: Bool = true,
        gradientBeamEnabled: Bool = true,
        cornerRadius: CGFloat = 99
    ) -> some View {
        modifier(
            BorderBeamEffect(
                borderColor: borderColor,
                beamColors: beamColors,
                beamEnabled: beamEnabled,
                gradientBeamEnabled: gradientBeamEnabled,
                cornerRadius: cornerRadius
            )
        )
    }
}

struct BorderBeamPractice: View {
    @State private var text: String = ""
    @State private var showBeamStroke: Bool = true
    @State private var showGradientBeam: Bool = true

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            VStack {
                // Toggles above the whole content
                Toggle("Beam Stroke", isOn: $showBeamStroke)
                Toggle("Gradient Beam", isOn: $showGradientBeam)
            }.padding()
            // Original content card
            VStack {
                TextField("Ask any question...", text: $text)
                    .padding(15)
                    .foregroundStyle(.white)

                HStack {
                    Spacer()
                    Button {} label: {
                        Image(systemName: "arrow.up").padding()
                            .borderBeamEffect(
                                borderColor: .primary,
                                beamColors: [
                                    .pink,
                                    .green,
                                    .blue,
                                    .purple,
                                ],
                                beamEnabled: showBeamStroke,
                                gradientBeamEnabled: showGradientBeam,
                                cornerRadius: 40
                            )
                    }
                }
            }
            .foregroundStyle(Color.primary)
            .padding().background(
                .gray.opacity(0.1),
                in: .rect(cornerRadius: 14)
            )
            .borderBeamEffect(
                borderColor: .primary,
                beamColors: [
                    .red,
                    .green,
                    .blue,
                    .purple,
                ],
                beamEnabled: showBeamStroke,
                gradientBeamEnabled: showGradientBeam,
                cornerRadius: 14
            )
            .padding()
        }
        .navigationTitle("Border Beam")
    }
}

#Preview {
    NavigationStack {
        BorderBeamPractice()
    }
}
