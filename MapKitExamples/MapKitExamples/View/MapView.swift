//
//  MapView.swift
//  MapKitExamples
//
//  Created by Yuunan kin on 2025/02/07.
//

import MapKit
import SwiftUI

struct MapView: View {
    @Binding var zoom: Double

    @State private var mapStyle: MapStyle = .hybrid
    @State private var cameraPosition: MapCameraPosition = .automatic
//    .userLocation(
//        fallback: .automatic
//    )

    var span: MKCoordinateSpan {
        .init(latitudeDelta: zoom, longitudeDelta: zoom)
    }

    let initialCenter: CLLocationCoordinate2D = .init(latitude: 37.33182, longitude: -122.03118)

    var region: MKCoordinateRegion {
        MKCoordinateRegion(center: initialCenter, span: span)
    }

    @State private var visibleRegion: MKCoordinateRegion?

    var body: some View {
        Map(position: $cameraPosition
//            ,interactionModes: [.pan, .zoom]
        ) {
            ForEach(MyLocation.locations) { location in
                Marker(
                    location.name,
                    coordinate: location.coordinate
                )
                .tint(location.color)
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
        .mapStyle(mapStyle)
        .mapControls {
            MapScaleView()
            MapCompass()
            MapPitchToggle()
        }
        .onMapCameraChange { context in
            visibleRegion = context.region
        }

        .onChange(
            of: zoom)
        {
            _,
                _ in
            cameraPosition = .region(
                MKCoordinateRegion(
                    center: visibleRegion?.center ?? initialCenter,
                    span: span
                )
            )
        }
        .onAppear {
            cameraPosition = .region(region)
        }
    }
}

#Preview {
    MapView(zoom: .constant(0.2))
}
