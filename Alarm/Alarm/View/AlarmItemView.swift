//
//  AlarmItemView.swift
//  Alarm
//
//  Created by Yuunan kin on 2025/02/15.
//

import SwiftUI

struct AlarmItemView: View {
    @Environment(AlarmViewModel.self) var viewModel
    let alarm: AlarmModel
    @State var enabled: Bool
    var body: some View {
        HStack {
            Button(action: {}) {
                HStack(spacing: 20) {
                    Image(systemName: alarm.activity)
                        .imageScale(.large)
                        .foregroundStyle(mainColors[alarm.colorIndex])
                    Text(
                        "\(alarm.start.shortDateString()) - \(alarm.end.shortDateString())"
                    ).font(.title)
                        .foregroundStyle(.myBlue)
                        .opacity(alarm.enabled ? 1 : 0.5)
                }
            }
            Spacer()
            ToggleView(enabled: $enabled)
        }
        .onChange(of: enabled) { _, newValue in
            viewModel.update(model: alarm, enabled: newValue)
        }
        .onChange(of: alarm.enabled) { _, newValue in
            enabled = newValue
        }
    }
}
