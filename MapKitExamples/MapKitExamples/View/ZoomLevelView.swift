//
//  ZoomLevelView.swift
//  MapKitExamples
//
//  Created by Yuunan kin on 2025/02/07.
//

import SwiftUI

struct ZoomLevelView: View {
    @Binding var zoom: Double
    @Binding var pinned: Bool
    var body: some View {
        VStack {
            Text("Zoom Level")
            HStack {
                Text("\(0.05.formatted())")
                Slider(value: $zoom, in: 0.05 ... 0.3).padding()
                Text("\(0.3.formatted())")

            }.foregroundStyle(.gray)
            Button(action: {
                withAnimation {
                    pinned.toggle()
                }
            }) {
                Label("Pin", systemImage: pinned ? "pin.slash.fill" : "pin.fill")
                    .foregroundStyle(pinned ? .blue : .gray)
            }
        }
        .padding()
        .background(
            Material.ultraThin,
            in: RoundedRectangle(cornerRadius: 10)
        )
    }
}

#Preview {
    ZoomLevelView(zoom: .constant(0.2), pinned: .constant(false))
}
