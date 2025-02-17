//
//  TimeModel.swift
//  Alarm
//
//  Created by Yuunan kin on 2025/02/14.
//

import Foundation

struct TimeModel: Equatable, Comparable, Identifiable {
    let id = UUID()
    let hours: Int
    let minutes: Int

    static func < (lhs: TimeModel, rhs: TimeModel) -> Bool {
        if lhs.hours != rhs.hours {
            lhs.hours < rhs.hours
        } else {
            lhs.minutes < rhs.minutes
        }
    }
}
