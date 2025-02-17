//
//  AlarmModel.swift
//  Alarm
//
//  Created by Yuunan kin on 2025/02/14.
//

import SwiftData
import SwiftUI

@Model
class AlarmModel: Identifiable {
    var id: String = UUID().uuidString
    init(
        title: String,
        details: String,
        repeats: Bool,
        sound: Sounds,
        enabled: Bool,
        start: Date,
        end: Date,
        activity: String,
        colorIndex: Int
    ) {
        self.title = title
        self.details = details
        self.repeats = repeats
        self.sound = sound
        self.enabled = enabled
        self.start = start
        self.end = end
        self.activity = activity
        self.colorIndex = colorIndex
    }

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

    var title: String
    var details: String

    var repeats: Bool
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
