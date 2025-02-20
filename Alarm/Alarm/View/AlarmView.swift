//
//  AlarmView.swift
//  Alarm
//
//  Created by Yuunan kin on 2025/02/12.
//

import SwiftData
import SwiftUI

struct AlarmView: View {
    @Environment(\.scenePhase) var scenePhase
    @Environment(LocalNotificationManager.self) var localNotificationManager

    @State var viewModel: AlarmViewModel
    var pendingAlarms: [UNNotificationRequest] {
        localNotificationManager.pendingAlarms
    }

    init(
        context: ModelContext,
        notificationManager: LocalNotificationManager
    ) {
        _viewModel = State(
            initialValue: AlarmViewModel(
                modelContext: context,
                notificationManager: notificationManager
            )
        )
    }

    var body: some View {
        ZStack {
            if !localNotificationManager.isAuthorized {
                EnableNotificationsView()
            } else {
                MainAlarmView().environment(viewModel)
            }
        }
        .task {
            try? await localNotificationManager.requestAuthorization()
            await localNotificationManager.getPendingAlarms()
        }
        .onChange(
            of: pendingAlarms)
        {
            _,
                _ in
            viewModel
                .updateEnabled(
                    currentPendingAlarms: pendingAlarms.map(\.identifier))
        }
        .onChange(of: scenePhase) {
            _,
                newValue in
            if newValue == .active {
                Task {
                    await localNotificationManager.getCurrentSettings()
                    await localNotificationManager.getPendingAlarms()
                    viewModel
                        .updateEnabled(
                            currentPendingAlarms: localNotificationManager
                                .pendingAlarms.map(\.identifier))
                }
            }
        }
    }
}

struct MainAlarmView: View {
    @Environment(AlarmViewModel.self) var viewModel
    var alarms: [AlarmModel] {
        viewModel.alarms
    }

    @State private var presentAddEditScreen: Bool = false
    @State private var selectedAlarmIndex: Int? = nil

    var body: some View {
        NavigationStack {
            ZStack {
                List {
                    ForEach(
                        Array(alarms.enumerated()),
                        id: \.element.id
                    ) { index, alarm in
                        AlarmItemView(alarm: alarm)
                            .onTapGesture {
                                selectedAlarmIndex = index
                                presentAddEditScreen = true
                            }.padding(.vertical)
                    }
                    .onDelete(perform: viewModel.delete)
                }
                FourCircleBackgroundView(color1: .myYellow, color2: .clear)
                    .opacity(0.6)
                    .allowsHitTesting(false)
            }
            .sheet(
                isPresented: $presentAddEditScreen,
                onDismiss: {
                    selectedAlarmIndex = nil
                },
                content: {
                    AddEditAlarmView(
                        alarm: selectedAlarmIndex == nil ? nil : alarms[selectedAlarmIndex!],
                        isPresented: $presentAddEditScreen
                    )
                }
            )
            // don't know why, but without this, sometimes AddEditAlarmView gets nil for alarm first time after app launch
            .onChange(of: selectedAlarmIndex) { _, _ in
                //                print("⭐️ selectedAlarmIndex changed from \(oldValue ?? -1) to \(newValue ?? -1)")
            }
            //            .navigationTitle("Alarms")
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Alarms")
                        .font(.largeTitle)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        presentAddEditScreen = true
                    } label: {
                        Text("+").font(.largeTitle)
                    }
                }

                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
            }
        }
    }
}
