//
//  AddEditAlarmView.swift
//  Alarm
//
//  Created by Yuunan kin on 2025/02/15.
//

import SwiftUI

struct AddEditAlarmView: View {
    @Environment(AlarmViewModel.self) var viewModel
    @State var alarm: AlarmModel?
    @Binding var isPresented: Bool
    @State var enabled: Bool = false
    @State var colorIndex: Int = 0
    @State var activity: String = activities[0]

    var body: some View {
        NavigationStack {
            ZStack {
                Color.background.ignoresSafeArea()
                VStack {
                    // Fixme
                    EnableView(enabled: $enabled)
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
                        viewModel.add()
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
