//
//  Location.swift
//  MapKitExamples
//
//  Created by Yuunan kin on 2025/02/07.
//

import MapKit
import SwiftUI

struct MyLocation: Identifiable {
    let id: UUID = .init()
    let name: String
    let latitude: Double
    let longitude: Double
    let address: String
    let color: Color
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

extension [MyLocation] {
    var coordinates: [CLLocationCoordinate2D] {
        map(\.coordinate)
    }
}

extension MyLocation {
    static let appleHeadquarters: MyLocation = .init(
        name: "Apple Inc.",
        latitude: 37.33182,
        longitude: -122.03118,
        address: "1 Infinite Loop, Cupertino, CA 95014",
        color: .black
    )
    static let googleHeadquarters: MyLocation = .init(
        name: "Google Inc.",
        latitude: 37.42202,
        longitude: -122.08407,
        address: "1600 Amphitheatre Parkway, Mountain View, CA 94043",
        color: .yellow
    )
    static let microsoftHeadquarters: MyLocation = .init(
        name: "Microsoft Corporation",
        latitude: 47.64593207520287,
        longitude: -122.13208783242456,
        address: "One Microsoft Way, Redmond, WA 98052",
        color: .cyan
    )

    static let amazonHeadquarters: MyLocation = .init(
        name: "Amazon Inc.",
        latitude: 47.606209,
        longitude: -122.332071,
        address: "1-1-1 Seattle Center, Seattle, WA 98104",
        color: .orange
    )
    static let locations: [MyLocation] = [appleHeadquarters, googleHeadquarters, microsoftHeadquarters, amazonHeadquarters]
}
