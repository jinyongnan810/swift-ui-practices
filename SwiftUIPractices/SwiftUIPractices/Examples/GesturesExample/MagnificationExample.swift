//
//  MagnificationExample.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2025/01/20.
//

import SwiftUI

struct MagnificationExample: View {
    @State private var scale1: CGFloat = 1
    @State private var scale2: CGFloat = 1
    @Binding var storedState: CGFloat
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                MyTextView(text: "Stay Still")
                    .scaleEffect(scale1)
                    .gesture(
                        MagnificationGesture()
                            .onChanged { value in
                                scale1 = value
                            }
                            .onEnded { _ in
                            }
                    )
                Spacer()
                MyTextView(text: "Bounce Back")
                    .scaleEffect(scale2)
                    .gesture(
                        MagnificationGesture()
                            .onChanged { value in
                                scale2 = value
                            }
                            .onEnded { _ in
                                withAnimation {
                                    scale2 = 1
                                }
                            }
                    )
                Spacer()
                MyTextView(text: "State Stored")
                    .scaleEffect(storedState)
                    .gesture(
                        MagnificationGesture()
                            .onChanged { value in
                                storedState = value
                            }
                            .onEnded { _ in
                            }
                    )
                Spacer()
            }.navigationTitle("Magnification")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    MagnificationExample(storedState: .constant(1.0))
}
