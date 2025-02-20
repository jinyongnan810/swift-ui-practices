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

func posToDegree(_ pos: CGPoint) -> CGFloat {
    let x = pos.x
    let y = pos.y
    if x == 0 || y == 0 {
        if x == 0, y > 0 {
            return 180
        } else if x == 0, y < 0 {
            return 0
        } else if x > 0, y == 0 {
            return 90
        } else if x < 0, y == 0 {
            return 270
        } else {
            return 0
        }
    }
    let r = sqrt(x * x + y * y)
    let cosValue = (pow(x, 2) + pow(r, 2) - pow(y, 2)) / (2 * abs(x) * r)
    let acosValue = acos(cosValue)
    let angleBetweenXAndR = acosValue * 180 / .pi
    // print("⭐️ x: \(x), y: \(y), r: \(r), cosValue: \(cosValue), acosValue: \(acosValue), angleBetweenXAndR: \(angleBetweenXAndR)")
    if x > 0, y > 0 {
        return 90 + angleBetweenXAndR
    } else if x < 0, y > 0 {
        return 270 - angleBetweenXAndR
    } else if x < 0, y < 0 {
        return 270 + angleBetweenXAndR
    } else {
        return 90 - angleBetweenXAndR
    }
}

func degreeToTime(_ degree: CGFloat) -> Date {
    let percent = degree / 360
    let timeInMinutes = 24 * 60 * percent
    let hour = Int(timeInMinutes) / 60
    let minute = Int(timeInMinutes) % 60
    var dateComponents = DateComponents()
    dateComponents.hour = hour
    dateComponents.minute = minute
    return Calendar.current.date(from: dateComponents)!
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
