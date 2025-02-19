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
class LocalNotificationManager: NSObject {
    let center = UNUserNotificationCenter.current()
    var isAuthorized = false
    var pendingAlarms: [UNNotificationRequest] = []

    override init() {
        super.init()
        center.delegate = self
    }

    func requestAuthorization() async throws {
        try await center.requestAuthorization(options: [.sound, .badge, .alert])
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

    func getPendingAlarms() async {
        pendingAlarms = await center.pendingNotificationRequests()
        print("⭐️ pendingAlarms: \(pendingAlarms.count)")
    }

    func schedule(_ alarm: AlarmModel) async {
        let content = UNMutableNotificationContent()
        content.title = NSLocalizedString(alarm.title, comment: "")
        content.body = NSLocalizedString(alarm.details, comment: "")
        content.sound = customSound(alarm.sound)

        let trigger = UNCalendarNotificationTrigger(
            dateMatching: .init(
                hour: alarm.endTime.hours,
                minute: alarm.endTime.minutes
            ),
            repeats: alarm.repeats
        )

        let request = UNNotificationRequest(identifier: alarm.id, content: content, trigger: trigger)
        try? await center.add(request)
        await getPendingAlarms()
    }

    func removeSchedule(_ id: String) {
        center.removePendingNotificationRequests(withIdentifiers: [id])
        Task {
            await getPendingAlarms()
        }
    }

    private func customSound(_ sound: Sounds, fileExtension: String = "") -> UNNotificationSound? {
        let ext = fileExtension.isEmpty ? "" : ".\(fileExtension)"
        let fileName = "\(sound.rawValue)\(ext)"
        print("⭐️ fileName: \(fileName)")
        return UNNotificationSound(named: .init(rawValue: fileName))
    }
}

extension LocalNotificationManager: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_: UNUserNotificationCenter, willPresent _: UNNotification) async -> UNNotificationPresentationOptions {
        print("⭐️ willPresent")
        await getPendingAlarms()
        return [.sound, .banner]
    }

    func userNotificationCenter(_: UNUserNotificationCenter, didReceive _: UNNotificationResponse) async {
        print("⭐️ didReceive")
    }
}
