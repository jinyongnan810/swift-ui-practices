//
//  AlarmView.swift
//  Alarm
//
//  Created by Yuunan kin on 2025/02/12.
//

import SwiftData
import SwiftUI

struct AlarmView: View {
    @State var viewModel: AlarmViewModel
    var alarms: [AlarmModel] {
        viewModel.alarms
    }

    init(
        context: ModelContext
    ) {
        _viewModel = State(initialValue: AlarmViewModel(modelContext: context))
    }

    @State private var presentAddEditScreen: Bool = false
    @State private var selectedAlarmIndex: Int? = nil
    var body: some View {
        NavigationStack {
            ZStack {
                FourCircleBackgroundView(color1: .myYellow, color2: .clear)
                List {
                    ForEach(
                        Array(alarms.enumerated()),
                        id: \.element.id
                    ) { index, alarm in
                        AlarmItemView(alarm: alarm)
                            .onTapGesture {
                                withAnimation {
                                    presentAddEditScreen = true
                                    selectedAlarmIndex = index
                                }
                            }
                    }.listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                }.listStyle(.plain)
                    .padding()
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
        }.environment(viewModel)
    }
}
