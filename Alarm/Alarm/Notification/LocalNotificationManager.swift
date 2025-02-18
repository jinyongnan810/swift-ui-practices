//
//  LocalNotificationManager.swift
//  Alarm
//
//  Created by Yuunan kin on 2025/02/18.
//

import Foundation
import NotificationCenter
import Observation

@MainActor
@Observable
class LocalNotificationManager: NSObject, UNUserNotificationCenterDelegate {
    let center = UNUserNotificationCenter.current()
    var isAuthorized = false

    func requestAuthorization() async throws {
        try await center.requestAuthorization(options: [.alert, .badge, .sound])
        await getCurrentSettings()
    }

    func getCurrentSettings() async {
        let settings = await center.notificationSettings()
        isAuthorized = settings.authorizationStatus == .authorized
    }

    func openSettings() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(url)
        }
    }
}
