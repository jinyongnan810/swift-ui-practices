//
//  TripPlannerView.swift
//  MapKitExamples
//
//  Created by Yuunan kin on 2025/02/08.
//

import MapKit
import SwiftUI

// https://www.youtube.com/watch?v=efjxmrAIobU

struct TripPlannerView: View {
    @State private var position: MapCameraPosition = .automatic
    @State private var visibleRegion: MKCoordinateRegion?

    @State private var searchResults: [MKMapItem] = []
    @State private var selectedSearchResult: MKMapItem?
//    @State private var selectedSearchResult: Int?
    @State private var lookAroundPreviewScene: MKLookAroundScene?

    @State private var route: MKRoute?
    private var travelTime: String? {
        guard let route else { return nil }
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .abbreviated
        formatter.allowedUnits = [.hour, .minute]
        return formatter.string(from: route.expectedTravelTime)
    }

    var body: some View {
        Map(position: $position, selection: $selectedSearchResult) {
            UserAnnotation()

            Marker(
                "Apple Inc.",
                systemImage: "apple.logo",
                coordinate: MyLocation.appleHeadquarters.coordinate
            ) // .tag(1)
            Annotation(
                "Sign-in",
                coordinate: MyLocation.googleHeadquarters.coordinate
//                anchor: .bottom
            ) {
                Image(systemName: "suitcase")
                    .padding()
                    .foregroundStyle(.white)
                    .background(.blue)
                    .clipShape(.circle)
            } // .tag(2)
            MapCircle(center: MyLocation.appleHeadquarters.coordinate, radius: 10000)
                .foregroundStyle(.orange.opacity(0.6))

            ForEach(searchResults, id: \.self) { item in
                Marker(item: item)
            }
            if let route {
                MapPolyline(route)
                    .stroke(
                        Gradient(colors: [.purple, .blue, .pink, .red]),
                        style: .init(
                            lineWidth: 2,
                            lineCap: .round,
                            lineJoin: .round,
                            dash: [5, 10, 2, 3]
                        )
                    )
            }
        }.mapStyle(.hybrid(elevation: .realistic))
            .safeAreaInset(
                edge: .bottom,
                content: {
                    VStack {
                        if lookAroundPreviewScene != nil, route != nil {
                            ZStack {
                                LookAroundPreview(scene: $lookAroundPreviewScene)
                                Text("Estimated travel time: \(travelTime ?? "Unknown")")
                                    .foregroundStyle(.white)
                                    .padding()
                                    .frame(
                                        maxWidth: .infinity,
                                        maxHeight: .infinity,
                                        alignment: .bottomTrailing
                                    )
                            }
                            .clipShape(.rect(cornerRadius: 10))
                            .frame(maxHeight: 100)
                        }
                        HStack {
                            Spacer()
                            Button("Parks") {
                                search(for: "park")
                            }.buttonStyle(.borderedProminent)
                            Button("Toilets") {
                                search(for: "toilet")
                            }.buttonStyle(.borderedProminent)

                            Spacer()
                        }
                        HStack {
                            Button("Apple") {
                                position =
                                    .region(
                                        .init(
                                            center: MyLocation.appleHeadquarters.coordinate,
                                            latitudinalMeters: 1000,
                                            longitudinalMeters: 1000
                                        )
                                    )
                            }.buttonStyle(.borderedProminent)
                            Button("Google") {
                                position =
                                    .camera(
                                        MapCamera(
                                            centerCoordinate: MyLocation.googleHeadquarters.coordinate,
                                            distance: 1000, heading: 242, pitch: 60
                                        )
                                    )
                            }.buttonStyle(.borderedProminent)
                            Button("MySelf") {
                                position =
                                    .userLocation(fallback: .automatic)
                            }.buttonStyle(.borderedProminent)
                        }
                    }
                    .padding()
                    .background(.ultraThinMaterial)
                }
            )
            .mapControls {
                MapUserLocationButton()
                MapScaleView()
                MapCompass()
                MapPitchToggle()
            }
//            .onChange(of: searchResults) { _, _ in
//                position = .automatic
//            }
            .onChange(of: selectedSearchResult) { _, newValue in
                Task {
                    if let newValue {
                        await getScene(of: newValue.placemark.coordinate)
                    } else {
                        withAnimation {
                            lookAroundPreviewScene = nil
                        }
                    }
                }
            }
            .onChange(of: selectedSearchResult) { _, newValue in
                if newValue != nil {
                    getDirections()
                }
            }
            .onMapCameraChange(
                //                frequency: .continuous
                frequency: .onEnd
            ) { context in
                visibleRegion = context.region
            }
    }

    func search(for query: String) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = query
        request.resultTypes = .pointOfInterest
        request.region = visibleRegion ?? MKCoordinateRegion(
            center: MyLocation.appleHeadquarters.coordinate,
            latitudinalMeters: 10000,
            longitudinalMeters: 10000
        )
        Task {
            let search = MKLocalSearch(request: request)
            let response = try? await search.start()
            searchResults = response?.mapItems ?? []
        }
    }

    func getScene(of coordinate: CLLocationCoordinate2D) async {
        lookAroundPreviewScene = nil
        let request = MKLookAroundSceneRequest(
            coordinate: coordinate
        )
        if let scene = try? await request.scene {
            lookAroundPreviewScene = scene
        }
    }

    func getDirections() {
        route = nil
        guard let selectedSearchResult else { return }
        let request = MKDirections.Request()
        request.source = MKMapItem(
            placemark: .init(
                coordinate: MyLocation.appleHeadquarters.coordinate
            )
        )
        request.destination = selectedSearchResult
        Task {
            let directions = MKDirections(request: request)
            let response = try? await directions.calculate()
            route = response?.routes.first
        }
    }
}

#Preview {
    TripPlannerView()
}
