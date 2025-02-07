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

let locations: [MyLocation] = [
    .init(name: "Apple Inc.", latitude: 37.33182, longitude: -122.03118, address: "1 Infinite Loop, Cupertino, CA 95014"),
    .init(name: "Google Inc.", latitude: 37.42202, longitude: -122.08407, address: "1600 Amphitheatre Parkway, Mountain View, CA 94043"),
]
