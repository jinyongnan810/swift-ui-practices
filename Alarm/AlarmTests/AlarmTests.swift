//
//  AlarmTests.swift
//  AlarmTests
//
//  Created by Yuunan kin on 2025/02/20.
//

@testable import Alarm
import SwiftUI
import Testing

struct AlarmTests {
    @Test func testPosToDegree() async throws {
        let targets: [CGPoint] = [
            CGPoint(x: 1, y: 0),
            CGPoint(x: 1, y: 1),
            CGPoint(x: 0, y: 1),
            CGPoint(x: -1, y: 1),
            CGPoint(x: -1, y: 0),
            CGPoint(x: -1, y: -1),
            CGPoint(x: 0, y: -1),
            CGPoint(x: 1, y: -1),
        ]
        let expects: [CGFloat] = [
            90,
            135,
            180,
            225,
            270,
            315,
            0,
            45,
        ]
        for (index, target) in targets.enumerated() {
            #expect(round(posToDegree(target)) == round(expects[index]))
        }
    }

    @Test func testDegreeToTime() async throws {
        let targets: [CGFloat] = [
            0, 30, 60, 90, 120, 150, 180, 210, 240, 270, 300, 330,
        ]
        let expects: [Date] = [
            createDateByHourAndMinute(hour: 0, minute: 0),
            createDateByHourAndMinute(hour: 2, minute: 0),
            createDateByHourAndMinute(hour: 4, minute: 0),
            createDateByHourAndMinute(hour: 6, minute: 0),
            createDateByHourAndMinute(hour: 8, minute: 0),
            createDateByHourAndMinute(hour: 10, minute: 0),
            createDateByHourAndMinute(hour: 12, minute: 0),
            createDateByHourAndMinute(hour: 14, minute: 0),
            createDateByHourAndMinute(hour: 16, minute: 0),
            createDateByHourAndMinute(hour: 18, minute: 0),
            createDateByHourAndMinute(hour: 20, minute: 0),
            createDateByHourAndMinute(hour: 22, minute: 0),
        ]
        for (index, target) in targets.enumerated() {
            #expect(degreeToTime(target) == expects[index])
        }
    }

    private func createDateByHourAndMinute(hour: Int, minute: Int) -> Date {
        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = minute
        return Calendar.current.date(from: dateComponents)!
    }
}
