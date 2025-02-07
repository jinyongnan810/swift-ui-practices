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
            MapPolyline(coordinates: [
                MyLocation.appleHeadquarters.coordinate,
                MyLocation.googleHeadquarters.coordinate,
                MyLocation.microsoftHeadquarters
                    .coordinate,
                MyLocation.appleHeadquarters.coordinate,
            ]).stroke(.black, lineWidth: 3)
        }
    }
}

#Preview {
    ContentView()
}
