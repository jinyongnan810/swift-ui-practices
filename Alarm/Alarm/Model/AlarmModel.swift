//
//  AlarmModel.swift
//  Alarm
//
//  Created by Yuunan kin on 2025/02/14.
//

import SwiftData
import SwiftUI

typealias AlarmModel = AlarmModelSchema2.AlarmModel

enum AlarmModelSchema1: VersionedSchema {
    static var versionIdentifier: Schema.Version = .init(1, 0, 0)

    static var models: [any PersistentModel.Type] {
        [AlarmModel.self]
    }

    @Model
    final class AlarmModel: Identifiable {
        @Attribute(.unique) var id: String = UUID().uuidString
        init(
            title: String,
            details: String,
            repeats: Bool,
            sound: Sounds,
            enabled: Bool,
            start: Date,
            end: Date,
            activity: String,
            colorIndex: Int
        ) {
            self.title = title
            self.details = details
            self.repeats = repeats
            self.sound = sound
            self.enabled = enabled
            self.start = start
            self.end = end
            activityName = activity
            self.colorIndex = colorIndex
        }

        var title: String
        var details: String

        var repeats: Bool
        var sound: Sounds
        var enabled: Bool

        var start: Date
        var end: Date
        var interval: TimeInterval {
            end - start
        }

        var startTime: TimeModel {
            start.toTimeModel()
        }

        var endTime: TimeModel {
            end.toTimeModel()
        }

        var activityName: String
        var colorIndex: Int
        var activityColor: Color {
            mainColors[colorIndex]
        }
    }
}

enum AlarmModelSchema2: VersionedSchema {
    static var versionIdentifier: Schema.Version = .init(2, 0, 0)

    static var models: [any PersistentModel.Type] {
        [AlarmModel.self]
    }

    @Model
    final class AlarmModel: Identifiable {
        @Attribute(.unique) var id: String = UUID().uuidString
        init(
            title: String,
            details: String,
            repeats: Bool,
            sound: Sounds,
            enabled: Bool,
            start: Date,
            end: Date,
            activity: String,
            colorIndex: Int,
            hope: String = "not-set"
        ) {
            self.title = title
            self.details = details
            self.repeats = repeats
            self.sound = sound
            self.enabled = enabled
            self.start = start
            self.end = end
            activityName = activity
            self.colorIndex = colorIndex
            self.hope = hope
        }

        var title: String
        var details: String

        var repeats: Bool
        var sound: Sounds
        var enabled: Bool

        var start: Date
        var end: Date
        var interval: TimeInterval {
            end - start
        }

        var startTime: TimeModel {
            start.toTimeModel()
        }

        var endTime: TimeModel {
            end.toTimeModel()
        }

        var activityName: String
        var colorIndex: Int
        var activityColor: Color {
            mainColors[colorIndex]
        }

        // FIXME: this is very weird.
        // without this default value, app crash even migration is successful.
        // and with this default value, the value set in migration does not work at all.
        var hope: String = "some-hope"
    }
}

enum AlarmModelMigrationPlan: SchemaMigrationPlan {
    static var schemas: [any VersionedSchema.Type] {
        [AlarmModelSchema1.self, AlarmModelSchema2.self]
    }

    static var stages: [MigrationStage] {
        [migrateV1toV2]
    }

    static let migrateV1toV2 = MigrationStage.custom(
        fromVersion: AlarmModelSchema1.self,
        toVersion: AlarmModelSchema2.self,
        willMigrate: { context in
            let alarms = try? context.fetch(
                FetchDescriptor<AlarmModelSchema1.AlarmModel>()
            )
            print("⭐️ migrating alarms from v1 to v2, before: \(alarms?.count ?? 0)")
            for alarm in alarms ?? [] {
                let newAlarm: AlarmModelSchema2.AlarmModel = .init(
                    title: alarm.title,
                    details: alarm.details,
                    repeats: alarm.repeats,
                    sound: alarm.sound,
                    enabled: alarm.enabled,
                    start: alarm.start,
                    end: alarm.end,
                    activity: alarm.activityName,
                    colorIndex: alarm.colorIndex,
                    hope: "new property default value" // expecting this to be set when migrated, but it is not
                )
                newAlarm.id = alarm.id
                print(
                    "⭐️ inserting new alarm: \(newAlarm), \(newAlarm.hope)"
                )
                context.insert(newAlarm)
            }
            do {
                try context.save()
                print("⭐️ migration successful")
            } catch {
                print("⭐️ migration error: \(error)")
            }
        },
        didMigrate: { context in
            let newAlarms = try! context.fetch(
                FetchDescriptor<AlarmModel>()
            )
            print("⭐️ migrating alarms from v1 to v2, after: \(newAlarms.count)")
            for newAlarm in newAlarms {
                print("⭐️ new alarm: \(newAlarm), \(newAlarm.hope)")
            }
        }
    )
}
