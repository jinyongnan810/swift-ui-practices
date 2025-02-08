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
    let minZoom: Double = 0.05
    let maxZoom: Double = 0.3
    var body: some View {
        VStack {
            Text("Zoom Level")
            HStack {
                Text("\(minZoom.formatted())")
                Slider(value: $zoom, in: minZoom ... maxZoom).padding()
                Text("\(maxZoom.formatted())")
            }
            Button(action: {
                withAnimation {
                    pinned.toggle()
                }
            }) {
                Label("Pin", systemImage: pinned ? "pin.slash.fill" : "pin.fill")
                    .foregroundStyle(pinned ? .blue : .gray)
            }
        }
        .foregroundStyle(.gray)
        .padding()
        .background(
            Material.ultraThin
        )
        .clipShape(.rect(cornerRadius: 10))
        .shadow(radius: 5)
    }
}

#Preview {
    ZoomLevelView(zoom: .constant(0.2), pinned: .constant(false))
}
