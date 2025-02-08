//
//  MainView.swift
//  MapKitExamples
//
//  Created by Yuunan kin on 2025/02/07.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationStack {
            List {
                NavigationLink("Normal Map View") {
                    NormalMapView()
                }
                NavigationLink("Look AroundView") {
                    LookAroundView()
                }
                NavigationLink("Trip Planner") {
                    TripPlannerView()
                }
            }.navigationTitle("MapKit Examples")
        }
    }
}

#Preview {
    MainView()
}
