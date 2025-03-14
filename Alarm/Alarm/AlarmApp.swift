//
//  AlarmApp.swift
//  Alarm
//
//  Created by Yuunan kin on 2025/02/12.
//

import SwiftData
import SwiftUI

@main
struct AlarmApp: App {
    @State private var localNotificationManager: LocalNotificationManager = .init()
    let container: ModelContainer
    init() {
        do {
            container = try ModelContainer(
                for: AlarmModel.self,
                migrationPlan: AlarmModelMigrationPlan.self
            )
        } catch {
            fatalError("Unable to create ModelContainer: \(error)")
        }
    }

    var body: some Scene {
        WindowGroup {
            SplashScreenView()
                .environment(\.font, .customFont)
                .environment(localNotificationManager)
                .modelContainer(container)
        }
    }
}
