//
//  ContentView.swift
//  MapKitExamples
//
//  Created by Yuunan kin on 2025/02/07.
//

import MapKit
import SwiftUI

struct ContentView: View {
    var body: some View {
        Map {
            ForEach(MyLocation.locations) { location in
                Marker(
                    location.name,
                    coordinate: location.coordinate
                )
                .tint(.black)
            }
            MapPolyline(coordinates: MyLocation.locations.coordinates).stroke(
                Gradient(colors: [.purple, .blue, .pink, .red]),
                style: .init(
                    lineWidth: 2,
                    lineCap: .round,
                    lineJoin: .round,
                    dash: [5, 10, 2, 3]
                )
            )
        }
    }
}

#Preview {
    ContentView()
}
