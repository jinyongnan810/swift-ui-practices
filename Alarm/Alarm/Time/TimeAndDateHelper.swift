//
//  TimeAndDateHelper.swift
//  Alarm
//
//  Created by Yuunan kin on 2025/02/14.
//

import Foundation

func dateToPercent(_ date: Date) -> CGFloat {
    let result = getTimeComponents(date)
    return CGFloat(result.hour) / 24 + CGFloat(result.minute) / 1440
}

func getTimeComponents(_ time: Date) -> (hour: Int, minute: Int, day: Int, month: Int, year: Int) {
    let components = Calendar.current.dateComponents([.hour, .minute, .day, .month, .year], from: time)
    let hour = components.hour ?? 0
    let minute = components.minute ?? 0
    let day = components.day ?? 0
    let month = components.month ?? 0
    let year = components.year ?? 0
    return (hour, minute, day, month, year)
}

func getTimeOfDate(_ date: Date) -> String {
    let components = getTimeComponents(date)
    return String(format: "%02d:%02d", components.hour, components.minute)
}

func addHourToDate(date: Date, hours: Int, minutes: Int = 0) -> Date {
//    var dateComponents = DateComponents()
//    dateComponents.hour = hour
//    return Calendar.current.date(byAdding: dateComponents, to: date)!
    date.addingTimeInterval(TimeInterval(hours * 3600 + minutes * 60))
}

func currentDayWithHourSet(_ hour: Int) -> Date {
    Calendar.current
        .date(bySettingHour: hour, minute: 0, second: 0, of: Date())!
}
