//
//  RotationGestureExample.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2025/01/20.
//

import SwiftUI

struct RotationGestureExample: View {
    @State private var rotation1Current: Angle = .zero
    @State private var rotation1Ended: Angle = .zero
    private var rotation1: Angle {
        rotation1Current + rotation1Ended
    }

    @State private var rotation2: Angle = .zero

    @State var rotation3Current: Angle = .zero
    @Binding var rotation3Ended: Angle
    private var rotation3: Angle {
        rotation3Current + rotation3Ended
    }

    var body: some View {
        VStack {
            Spacer()
            MyTextView(text: "Stay Still")
                .rotationEffect(rotation1)
                .gesture(
                    RotateGesture()
                        .onChanged { value in
                            rotation1Current = value.rotation
                        }
                        .onEnded { _ in
                            rotation1Ended = rotation1
                            rotation1Current = .zero
                        }
                )
                .onTapGesture {
                    withAnimation {
                        rotation1Current = .zero
                        rotation1Ended = .zero
                    }
                }
            Spacer()
            MyTextView(text: "Bounce Back")
                .rotationEffect(rotation2)
                .gesture(
                    RotateGesture()
                        .onChanged { value in
                            rotation2 = value.rotation
                        }
                        .onEnded { _ in
                            withAnimation {
                                rotation2 = .zero
                            }
                        }
                )

            Spacer()
            MyTextView(text: "State Stored")
                .rotationEffect(rotation3)
                .gesture(
                    RotateGesture()
                        .onChanged { value in
                            rotation3Current = value.rotation
                        }
                        .onEnded { _ in
                            rotation3Ended = rotation3
                            rotation3Current = .zero
                        }
                ).onTapGesture {
                    withAnimation {
                        rotation3Current = .zero
                        rotation3Ended = .zero
                    }
                }

            Spacer()
        }.navigationTitle("Rotation")
            .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    RotationGestureExample(rotation3Ended: .constant(.zero))
}
