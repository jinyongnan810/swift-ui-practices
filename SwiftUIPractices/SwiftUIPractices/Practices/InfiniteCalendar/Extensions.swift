//
//  Extensions.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2026/01/12.
//
//  This file contains extensions for Date and [Month] to support
//  the infinite scrolling calendar functionality.
//
import SwiftUI

// Global date formatter for displaying month names in "yyyy MMMM" format (e.g., "2026 January")
let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy MMMM"
    return formatter
}()

extension Date {
    /// Generates an initial array of months for the calendar
    /// Creates 10 months total: 5 months before the current date and 4 months after (including current month)
    /// This provides the starting data for the infinite scrolling calendar
    var initialMonths: [Month] {
        let formatter = dateFormatter
        let calendar = Calendar.current

        var months: [Month] = []
        // Generate months from -5 (5 months ago) to +4 (4 months ahead)
        for offset in -5 ... 4 {
            if let date = calendar.date(byAdding: .month, value: offset, to: self) {
                let monthName = formatter.string(from: date)
                let weeks = date.weeksInMonth
                let month = Month(name: monthName, date: date, weeks: weeks)
                months.append(month)
            }
        }

        return months
    }

    /// Generates an array of weeks for the month
    /// Each week contains 7 days, with placeholder days for dates outside the current month
    /// This ensures the calendar grid is properly aligned with the first day of the month
    var weeksInMonth: [Week] {
        let calendar = Calendar.current
        // Get the date interval for the entire month
        // Get the date interval for the first week of the month (may include days from previous month)
        guard let monthInterval = calendar.dateInterval(of: .month, for: self), let monthFirstWeek = calendar.dateInterval(of: .weekOfMonth, for: monthInterval.start) else {
            return []
        }

        var weeks: [Week] = []
        var currentDate = monthFirstWeek.start
        // Iterate through all days in the month, week by week
        while currentDate < monthInterval.end {
            var days: [Day] = []
            // Each week has exactly 7 days
            for _ in 0 ..< 7 {
                // Check if the current date belongs to this month
                if calendar
                    .isDate(currentDate, equalTo: self, toGranularity: .month)
                {
                    // Create a real day with its date value
                    let value = calendar.component(.day, from: currentDate)
                    let day = Day(
                        value: value,
                        date: currentDate,
                        isPlaceholder: false
                    )
                    days.append(day)
                } else {
                    // Create a placeholder day for dates outside this month
                    days.append(.init(isPlaceholder: true))
                }
                currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate)!
            }
            let week = Week(days: days)
            weeks.append(week)
        }
        // Mark the last week of the month
        if let lastIndex = weeks.indices.last {
            weeks[lastIndex].isLast = true
        }
        return weeks
    }
}

extension [Month] {
    /// Creates additional months for infinite scrolling
    /// - Parameters:
    ///   - count: Number of months to generate
    ///   - isPast: If true, generates months before the first month; if false, generates months after the last month
    /// - Returns: Array of newly created months
    /// This method is used to dynamically load more months as the user scrolls in either direction
    func createMonths(count: Int, isPast: Bool) -> [Month] {
        let formatter = dateFormatter
        let calendar = Calendar.current
        // Get the reference month: first month for past, last month for future
        guard let month = isPast ? self.first?.date : self.last?.date else {
            return []
        }
        var newMonths: [Month] = []
        for index in 1 ... count {
            // Calculate offset: negative for past, positive for future
            let offset = isPast ? -index : index
            if let date = calendar.date(byAdding: .month, value: offset, to: month) {
                let monthName = formatter.string(from: date)
                let weeks = date.weeksInMonth
                let month = Month(name: monthName, date: date, weeks: weeks)
                if isPast {
                    // Insert past months at the beginning to maintain chronological order
                    newMonths.insert(month, at: 0)
                } else {
                    // Append future months at the end
                    newMonths.append(month)
                }
            }
        }
        return newMonths
    }
}
