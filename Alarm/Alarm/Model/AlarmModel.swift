//
//  AlarmModel.swift
//  Alarm
//
//  Created by Yuunan kin on 2025/02/14.
//

import SwiftUI

struct AlarmModel: Identifiable {
    let id: String = UUID().uuidString

    static func Default() -> AlarmModel {
        .init(
            title: "Default Alarm",
            details: "Have a good day!",
            repeats: false,
            sound: .bird_forest,
            enabled: true,
            start: Date().addingTimeInterval(60),
            end: Date().addingTimeInterval(120),
            activity: activities[0],
            colorIndex: 0
        )
    }

    static func Default2() -> AlarmModel {
        .init(
            title: "Default Alarm",
            details: "Have a good day!",
            repeats: false,
            sound: .christmas_bells,
            enabled: true,
            start: Date().addingTimeInterval(6000),
            end: Date().addingTimeInterval(12000),
            activity: activities[2],
            colorIndex: 4
        )
    }

    let title: String
    let details: String

    let repeats: Bool
    var sound: Sounds
    var enabled: Bool

    var start: Date
    var end: Date
    var interval: TimeInterval {
        end - start
    }

    var startTime: TimeModel {
        start.toTimeModel()
    }

    var endTime: TimeModel {
        end.toTimeModel()
    }

    var activity: String
    var colorIndex: Int
    var activityColor: Color {
        mainColors[colorIndex]
    }
}
