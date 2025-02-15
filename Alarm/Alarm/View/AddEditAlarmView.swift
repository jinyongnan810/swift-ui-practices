//
//  AddEditAlarmView.swift
//  Alarm
//
//  Created by Yuunan kin on 2025/02/15.
//

import SwiftUI

struct AddEditAlarmView: View {
    @State var alarm: AlarmModel
    @Binding var isPresented: Bool

    var body: some View {
        NavigationStack {
            ZStack {
                Color.background.ignoresSafeArea()
                VStack {
                    EnableView(enabled: $alarm.enabled)
                    Spacer()
                    SelectActivityView(
                        colorIndex: $alarm.colorIndex,
                        activity: $alarm.activity
                    )
                }.padding()
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
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

#Preview {
    AddEditAlarmView(alarm: .Default(), isPresented: .constant(true))
}
