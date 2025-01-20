//
//  GesturesExample.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2025/01/20.
//

import SwiftUI

struct GesturesExample: View {
    @State private var magnificationState: CGFloat = 1.0
    @State private var dragState: CGSize = .zero
    @State private var rotateState: Angle = .zero
    var body: some View {
        NavigationStack {
            List {
                NavigationLink("Magnification") {
                    MagnificationExample(storedState: $magnificationState)
                }
                NavigationLink("Drag") {
                    DragGestureExample(storedOffsetEnded: $dragState)
                }
                NavigationLink("Rotation") {
                    RotationGestureExample(rotation3Ended: $rotateState)
                }
                NavigationLink("Simultaneous") {
                    SimultaneousGestureExample()
                }
            }.navigationTitle("Explore Gestures")
        }
    }
}

#Preview {
    GesturesExample()
}
