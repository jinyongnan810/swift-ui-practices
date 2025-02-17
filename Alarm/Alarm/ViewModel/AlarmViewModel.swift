//
//  AlarmViewModel.swift
//  Alarm
//
//  Created by Yuunan kin on 2025/02/17.
//

import Foundation
import Observation
import SwiftData

@Observable
class AlarmViewModel {
    var alarms: [AlarmModel] = []
    var modelContext: ModelContext

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        fetch()
    }

    func fetch() {
        do {
            // TODO: change to order by TimeModel
            let descriptor = FetchDescriptor<AlarmModel>(
                sortBy: [SortDescriptor(\.start, order: .forward)]
            )
            alarms = try modelContext.fetch(descriptor)
            print("⭐️ Fetched: \(alarms)")
        } catch {
            print("⭐️ Fetching failed: \(error)")
        }
    }

    func add(enabled: Bool, colorIndex: Int, activity: String, start: Date, end: Date) {
        let newAlarm = AlarmModel(
            title: "not-set",
            details: "not-set",
            repeats: false,
            sound: .bird_forest,
            enabled: enabled,
            start: start,
            end: end,
            activity: activity,
            colorIndex: colorIndex
        )
        modelContext.insert(newAlarm)
        save()
    }

    func update(model: AlarmModel, enabled: Bool? = nil, colorIndex: Int? = nil, activity: String? = nil, start: Date? = nil, end: Date? = nil) {
        model.enabled = enabled ?? model.enabled
        model.colorIndex = colorIndex ?? model.colorIndex
        model.activity = activity ?? model.activity
        model.start = start ?? model.start
        model.end = end ?? model.end
        save()
    }

    func save() {
        do {
            try modelContext.save()
            fetch()
        } catch {
            print("⭐️ Save failed: \(error)")
        }
    }
}
