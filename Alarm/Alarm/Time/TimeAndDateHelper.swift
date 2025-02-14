//
//  TimeAndDateHelper.swift
//  Alarm
//
//  Created by Yuunan kin on 2025/02/14.
//

import Foundation

func currentDayWithHourSet(_ hour: Int) -> Date {
    Calendar.current
        .date(bySettingHour: hour, minute: 0, second: 0, of: Date())!
}

extension Date {
    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        .init(lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate)
    }

    func components() -> (hour: Int, minute: Int, day: Int, month: Int, year: Int) {
        let components = Calendar.current.dateComponents([.hour, .minute, .day, .month, .year], from: self)
        let hour = components.hour ?? 0
        let minute = components.minute ?? 0
        let day = components.day ?? 0
        let month = components.month ?? 0
        let year = components.year ?? 0
        return (hour, minute, day, month, year)
    }

    func percent() -> CGFloat {
        let components = components()
        return CGFloat(components.hour) / 24 + CGFloat(components.minute) / 1440
    }

    func shortDateString() -> String {
        let components = components()
        return String(format: "%02d:%02d", components.hour, components.minute)
    }

    func fullDateString() -> String {
        let components = components()
        return String(format: "%04d/%02d/%02d %02d:%02d", components.year, components.month, components.day, components.hour, components.minute)
    }

    func addHoursAndMinutes(_ hours: Int, _ minutes: Int = 0) -> Date {
        addingTimeInterval(TimeInterval(hours * 3600 + minutes * 60))
    }

    func toTimeModel() -> TimeModel {
        let components = components()
        return TimeModel(hours: components.hour, minutes: components.minute)
    }
}
