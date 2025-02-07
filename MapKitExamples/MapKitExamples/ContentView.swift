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
            ForEach(locations) { location in
                Marker(
                    location.name,
                    coordinate: location.coordinate
                )
                .tint(.black)
            }
        }
    }
}

#Preview {
    ContentView()
}
