//
//  PhaseAnimationExample.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2025/01/19.
//

import SwiftUI

struct AnimationProperties: Equatable {
    let color: Color
    let scale: CGFloat
}

enum Phase: CaseIterable {
    case start, middle, end
}

struct PhaseAnimationExample: View {
    @State private var animated = false
    let phases: [AnimationProperties] = [
        .init(color: .blue, scale: 1),
        .init(color: .orange, scale: 1.5),
        .init(color: .purple, scale: 1.2),
    ]

    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .phaseAnimator(phases, trigger: animated) { view, phase in
                    view.foregroundStyle(phase.color.gradient)
                        .scaleEffect(x: phase.scale, y: phase.scale)
                }
                .onTapGesture {
                    animated.toggle()
                }

            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .phaseAnimator(
                    Phase.allCases,
                    trigger: animated
                ) {
                    view,
                        phase in
                    view
                        .padding()
                        .background(
                            phase == .middle ? Color.yellow : Color.clear
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .overlay {
                            if phase == .middle {
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(.green, lineWidth: 3)
                            }
                        }
                }
                .onTapGesture {
                    animated.toggle()
                }

            Image(ImageResource.deepdive).resizable()
                .scaledToFit()
                .phaseAnimator([0, 15, 30]) { view, phase in
                    view.overlay {
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(lineWidth: phase)
                    }
                    .cornerRadius(20)
                    .padding()
                }
        }
    }
}

#Preview {
    PhaseAnimationExample()
}
