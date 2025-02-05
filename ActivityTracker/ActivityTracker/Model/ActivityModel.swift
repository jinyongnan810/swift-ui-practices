//
//  ActivityModel.swift
//  ActivityTracker
//
//  Created by Yuunan kin on 2025/02/05.
//

import Foundation
import SwiftData

@Model
class Activity {
    @Attribute(.unique)
    var id: String = UUID().uuidString

    var name: String
    var hoursPerDay: Double

    init(name: String, hoursPerDay: Double = 0) {
        self.name = name
        self.hoursPerDay = hoursPerDay
    }
}
