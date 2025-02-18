//
//  AddEditAlarmView.swift
//  Alarm
//
//  Created by Yuunan kin on 2025/02/15.
//

import SwiftUI

struct AddEditAlarmView: View {
    @Environment(AlarmViewModel.self) var viewModel
    var alarm: AlarmModel?
    @Binding var isPresented: Bool
    @State var enabled: Bool
    @State var colorIndex: Int
    @State var activity: String
    @State var start: Date
    @State var end: Date

    init(
        alarm: AlarmModel? = nil,
        isPresented: Binding<Bool>
    ) {
        self.alarm = alarm
        _isPresented = isPresented
        if let alarm {
            _enabled = .init(wrappedValue: alarm.enabled)
            _colorIndex = .init(wrappedValue: alarm.colorIndex)
            _activity = .init(wrappedValue: alarm.activity)
            _start = .init(wrappedValue: alarm.start)
            _end = .init(wrappedValue: alarm.end)
        } else {
            _enabled = .init(wrappedValue: true)
            _colorIndex = .init(wrappedValue: 0)
            _activity = .init(wrappedValue: activities[0])
            _start = .init(wrappedValue: Date().addingTimeInterval(60))
            _end = .init(wrappedValue: Date().addingTimeInterval(420))
        }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color.background.ignoresSafeArea()
                VStack {
                    EnableView(enabled: $enabled)
                    Spacer()

                    ArcView(start: $start, end: $end)

                    Spacer()
                    SelectActivityView(
                        colorIndex: $colorIndex,
                        activity: $activity
                    )
                }.padding()
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        if alarm != nil {
                            viewModel
                                .update(
                                    model: alarm!,
                                    enabled: enabled,
                                    colorIndex: colorIndex,
                                    activity: activity,
                                    start: start,
                                    end: end
                                )
                        } else {
                            viewModel
                                .add(
                                    enabled: enabled,
                                    colorIndex: colorIndex,
                                    activity: activity,
                                    start: start,
                                    end: end
                                )
                        }

                        isPresented = false
                    } label: {
                        Text("Save")
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        isPresented = false
                    } label: {
                        Text("Cancel")
                    }
                }
            }
        }
    }
}

struct EnableView: View {
    @Binding var enabled: Bool

    var body: some View {
        HStack {
            Text("Enabled")
                .font(.headline)
            Spacer()
            ToggleView(enabled: $enabled)
        }
    }
}
