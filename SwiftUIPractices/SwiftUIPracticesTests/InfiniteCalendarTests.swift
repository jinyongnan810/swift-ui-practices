//
//  InfiniteCalendarTests.swift
//  SwiftUIPracticesTests
//
//  Created by Yuunan kin on 2026/01/13.
//

import Foundation
@testable import SwiftUIPractices
import Testing

let dateFormatter = {
    let formatter = DateFormatter()
    formatter.calendar = Calendar(identifier: .gregorian)
    formatter.locale = Locale(identifier: "en_US_POSIX")
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    formatter.dateFormat = "yyyy-MM-dd"
    return formatter
}()

struct InfiniteCalendarTests {
    @Test func testInitialMonths() async throws {
        let formatter = dateFormatter
        let dateString = "2026-01-13"
        let date = try #require(formatter.date(from: dateString), "Failed to parse date from yyyy-MM-dd string")

        let initialMonths = date.initialMonths

        // Verify total count: 5 months before + current month + 4 months after = 10 months
        #expect(initialMonths.count == 10)

        // Verify the month names are in chronological order
        let expectedMonthNames = [
            "2025 August", // -5 months
            "2025 September", // -4 months
            "2025 October", // -3 months
            "2025 November", // -2 months
            "2025 December", // -1 month
            "2026 January", // current month
            "2026 February", // +1 month
            "2026 March", // +2 months
            "2026 April", // +3 months
            "2026 May", // +4 months
        ]

        for (index, month) in initialMonths.enumerated() {
            // Verify each month name matches expected
            #expect(month.name == expectedMonthNames[index], "Month at index \(index) should be \(expectedMonthNames[index]) but was \(month.name)")

            // Verify each month has weeks
            #expect(!month.weeks.isEmpty, "Month \(month.name) should have weeks")
        }

        // Verify first month
        #expect(initialMonths.first?.name == "2025 August")

        // Verify last month
        #expect(initialMonths.last?.name == "2026 May")

        // Verify the middle month (index 5) is the current month
        #expect(initialMonths[5].name == "2026 January")
    }

    @Test
    func testWeeksInMonth() async throws {
        let formatter = dateFormatter
        let dateString = "2026-01-13"
        let date = try #require(formatter.date(from: dateString), "Failed to parse date from yyyy-MM-dd string")

        let weeks: [Week] = date.weeksInMonth

        // January 2026 spans 5 weeks (starts on Thursday, ends on Saturday)
        #expect(weeks.count == 5, "January 2026 should have 5 weeks")

        // Verify each week has exactly 7 days
        for (weekIndex, week) in weeks.enumerated() {
            #expect(week.days.count == 7, "Week \(weekIndex) should have exactly 7 days")
        }

        // Verify the last week is marked as isLast
        #expect(weeks.last?.isLast == true, "Last week should have isLast flag set to true")

        // Verify non-last weeks don't have isLast flag
        for weekIndex in 0 ..< (weeks.count - 1) {
            #expect(weeks[weekIndex].isLast == false, "Week \(weekIndex) should not be marked as last")
        }

        // January 2026 starts on Thursday (Jan 1) so first 3 days should be placeholders
        let firstWeek = weeks[0]
        var placeholderCount = 0
        var realDayCount = 0

        for day in firstWeek.days {
            if day.isPlaceholder {
                placeholderCount += 1
            } else {
                realDayCount += 1
            }
        }

        // First week should have 3 placeholder days (Sun, Mon, Tue) and 4 real days (Thu-Sat: 1-4)
        #expect(placeholderCount == 3, "First week should have 3 placeholder days")
        #expect(realDayCount == 4, "First week should have 4 real days")

        // Verify first real day is January 1st
        let firstRealDay = firstWeek.days.first(where: { !$0.isPlaceholder })
        #expect(firstRealDay?.value == 1, "First real day should be day 1")

        // Verify last week of January ends with day 31
        let lastWeek = weeks[weeks.count - 1]
        let lastRealDay = lastWeek.days.last(where: { !$0.isPlaceholder })
        #expect(lastRealDay?.value == 31, "Last real day should be day 31")

        // Count total real (non-placeholder) days across all weeks
        let totalRealDays = weeks.flatMap(\.days).filter { !$0.isPlaceholder }.count
        #expect(totalRealDays == 31, "January should have exactly 31 real days")

        // Verify all real days have dates and sequential day values
        let allRealDays = weeks.flatMap(\.days).filter { !$0.isPlaceholder }
        for (index, day) in allRealDays.enumerated() {
            let expectedDayValue = index + 1
            #expect(day.value == expectedDayValue, "Day at position \(index) should have value \(expectedDayValue)")
            #expect(day.date != nil, "Day \(day.value) should have a valid date")
        }
    }
}
