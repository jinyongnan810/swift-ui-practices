//
//  SimultaneousGestureExample.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2025/01/20.
//

import SwiftUI

struct SimultaneousGestureExample: View {
    @State private var rotationCurrent: Angle = .zero
    @State private var rotationEnded: Angle = .zero
    private var rotation: Angle {
        rotationCurrent + rotationEnded
    }

    @State private var draggingOffsetCurrent: CGSize = .zero
    @State private var draggingOffsetEnded: CGSize = .zero
    private var offset: CGSize {
        CGSize(
            width: draggingOffsetCurrent.width + draggingOffsetEnded.width,
            height: draggingOffsetCurrent.height + draggingOffsetEnded.height
        )
    }

    @State private var magnification: CGFloat = 1

    var body: some View {
        NavigationStack {
            MyTextView(text: "Simultaneous Gesture")
                .rotationEffect(rotation)
                .offset(offset)
                .scaleEffect(magnification)
                .gesture(
                    SimultaneousGesture(SimultaneousGesture(DragGesture()
                            .onChanged { value in
                                withAnimation {
                                    draggingOffsetCurrent = value.translation
                                }

                            }
                            .onEnded { _ in
                                draggingOffsetEnded = offset
                                draggingOffsetCurrent = .zero
                            }, MagnificationGesture()
                            .onChanged { value in
                                withAnimation {
                                    magnification = value
                                }

                            }), RotateGesture()
                        .onChanged { value in
                            withAnimation {
                                rotationCurrent = value.rotation
                            }

                        }
                        .onEnded { _ in
                            rotationEnded = rotation
                            rotationCurrent = .zero
                        })
                )
                .onTapGesture {
                    withAnimation {
                        rotationCurrent = .zero
                        rotationEnded = .zero
                        draggingOffsetEnded = .zero
                        draggingOffsetCurrent = .zero
                        magnification = 1
                    }
                }.navigationTitle("Simultaneous Gesture")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    SimultaneousGestureExample()
}
