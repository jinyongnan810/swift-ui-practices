//
//  AlarmView.swift
//  Alarm
//
//  Created by Yuunan kin on 2025/02/12.
//

import SwiftUI

struct AlarmView: View {
    @State private var presentAddEditScreen: Bool = false
    var body: some View {
        NavigationStack {
            ZStack {
                FourCircleBackgroundView(color1: .myYellow, color2: .clear)
                VStack {
                    Image(systemName: "globe")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                    Text("Hello, world!")
                        .font(.largeTitle)
                    Text("Hello, world!")
                }
                .padding()
            }
            .fullScreenCover(isPresented: $presentAddEditScreen, content: {
                AddEditAlarmView(alarm: .Default(), isPresented: $presentAddEditScreen)
            })
            .navigationTitle("Alarms")
            .toolbar {
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

#Preview {
    AlarmView()
}
