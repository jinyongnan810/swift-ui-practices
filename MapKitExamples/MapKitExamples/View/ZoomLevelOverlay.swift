//
//  ZoomLevelOverlay.swift
//  MapKitExamples
//
//  Created by Yuunan kin on 2025/02/07.
//

import SwiftUI

struct ZoomLevelOverlay: View {
    @State private var offsetCurrent: CGSize = .zero
    @State private var offsetEnded: CGSize = .zero
    private var offset: CGSize {
        .init(
            width: offsetEnded.width + offsetCurrent.width,
            height: offsetEnded.height + offsetCurrent.height
        )
    }

    @Binding var zoom: Double

    @State private var pinned: Bool = false

    var body: some View {
        ZStack {
            ZoomLevelView(zoom: $zoom, pinned: $pinned)
                .offset(offset)
                .gesture(DragGesture().onChanged { value in
                    offsetCurrent = value.translation
                }
                .onEnded { _ in
                    withAnimation {
                        offsetEnded = pinned ? offset : .zero
                        offsetCurrent = .zero
                    }
                })
                .onChange(of: pinned) { _, newValue in
                    if !newValue {
                        withAnimation {
                            offsetEnded = .zero
                            offsetCurrent = .zero
                        }
                    }
                }.frame(maxHeight: .infinity, alignment: .bottom)

        }.padding()
    }
}

#Preview {
    ZoomLevelOverlay(zoom: .constant(0.2))
}
