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
    var notificationManager: LocalNotificationManager

    init(modelContext: ModelContext, notificationManager: LocalNotificationManager) {
        self.modelContext = modelContext
        self.notificationManager = notificationManager
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

    func add(enabled: Bool, colorIndex: Int, activity: String, start: Date, end: Date, sound: Sounds) {
        let newAlarm = AlarmModel(
            title: "Alarm",
            details: "Have a nice day!",
            repeats: false,
            sound: sound,
            enabled: enabled,
            start: start,
            end: end,
            activity: activity,
            colorIndex: colorIndex
        )
        modelContext.insert(newAlarm)
        save()

        if newAlarm.enabled {
            Task {
                await notificationManager.schedule(newAlarm)
            }
        }
    }

    func update(model: AlarmModel, enabled: Bool? = nil, colorIndex: Int? = nil, activity: String? = nil, start: Date? = nil, end: Date? = nil, sound: Sounds? = nil) {
        model.enabled = enabled ?? model.enabled
        model.colorIndex = colorIndex ?? model.colorIndex
        model.activity = activity ?? model.activity
        model.start = start ?? model.start
        model.end = end ?? model.end
        model.sound = sound ?? model.sound
        save()
        if model.enabled {
            Task {
                await notificationManager.schedule(model)
            }
        } else {
            Task {
                await notificationManager
                    .removeSchedule(model.id)
            }
        }
    }

    func updateEnabled(currentPendingAlarms: [String]) {
        var hasChange = false
        for index in 0 ..< alarms.count {
            if alarms[index].enabled {
                if !currentPendingAlarms.contains(alarms[index].id) {
                    alarms[index].enabled = false
                    hasChange = true
                }
            }
        }
        if hasChange {
            save()
        }
    }

    func delete(indexSet: IndexSet) {
        for index in indexSet {
            if alarms[index].enabled {
                Task {
                    await notificationManager
                        .removeSchedule(alarms[index].id)
                }
            }
            modelContext.delete(alarms[index])
        }
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
