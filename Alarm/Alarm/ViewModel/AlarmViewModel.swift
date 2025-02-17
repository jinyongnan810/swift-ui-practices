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
            let descriptor = FetchDescriptor<AlarmModel>(
                sortBy: [SortDescriptor(\.end, order: .forward)]
            )
            alarms = try modelContext.fetch(descriptor)
            print("⭐️ Fetched: \(alarms)")
        } catch {
            print("⭐️ Fetching failed: \(error)")
        }
    }

    func add() {
        let newAlarm = [AlarmModel.Default(), AlarmModel.Default2()].randomElement()!
        modelContext.insert(newAlarm)
        save()
    }

    func update(model: AlarmModel, enabled: Bool? = nil, colorIndex: Int? = nil, activity: String? = nil) {
        model.enabled = enabled ?? model.enabled
        model.colorIndex = colorIndex ?? model.colorIndex
        model.activity = activity ?? model.activity
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
