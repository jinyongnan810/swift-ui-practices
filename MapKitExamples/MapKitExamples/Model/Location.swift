//
//  Location.swift
//  MapKitExamples
//
//  Created by Yuunan kin on 2025/02/07.
//

import Foundation
import MapKit

struct MyLocation: Identifiable {
    let id: UUID = .init()
    let name: String
    let latitude: Double
    let longitude: Double
    let address: String
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

extension MyLocation {
    static let appleHeadquarters: MyLocation = .init(
        name: "Apple Inc.",
        latitude: 37.33182,
        longitude: -122.03118,
        address: "1 Infinite Loop, Cupertino, CA 95014"
    )
    static let googleHeadquarters: MyLocation = .init(
        name: "Google Inc.",
        latitude: 37.42202,
        longitude: -122.08407,
        address: "1600 Amphitheatre Parkway, Mountain View, CA 94043"
    )
    static let microsoftHeadquarters: MyLocation = .init(
        name: "Microsoft Corporation",
        latitude: 37.4324,
        longitude: -122.0311,
        address: "One Microsoft Way, Redmond, WA 98052"
    )
    static let locations: [MyLocation] = [appleHeadquarters, googleHeadquarters, microsoftHeadquarters]
}
