//
//  ActivityTrackerApp.swift
//  ActivityTracker
//
//  Created by Yuunan kin on 2025/02/05.
//

import SwiftData
import SwiftUI

@main
struct ActivityTrackerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }.modelContainer(for: Activity.self)
    }
}
