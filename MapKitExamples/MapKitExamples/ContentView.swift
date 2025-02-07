//
//  ContentView.swift
//  MapKitExamples
//
//  Created by Yuunan kin on 2025/02/07.
//

import MapKit
import SwiftUI

struct ContentView: View {
    @State private var zoom: Double = 0.05

    var body: some View {
        ZStack {
            MapView(zoom: $zoom)

            VStack {
//                TitleView()
                Spacer()
            }

            ZoomLevelOverlay(zoom: $zoom)
        }
    }
}

#Preview {
    ContentView()
}
