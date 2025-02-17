//
//  AlarmItemView.swift
//  Alarm
//
//  Created by Yuunan kin on 2025/02/15.
//

import SwiftUI

struct AlarmItemView: View {
    let alarm: AlarmModel
    var body: some View {
        HStack {
            Image(systemName: alarm.activity)
                .imageScale(.large)
                .foregroundStyle(mainColors[alarm.colorIndex])
            Spacer()
            Text(
                "\(alarm.start.shortDateString()) - \(alarm.end.shortDateString())"
            ).font(.title)
                .foregroundStyle(.myBlue)
            Spacer()
            ToggleView(enabled: .constant(alarm.enabled))
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 12).fill(.white.opacity(0.8)))
        .clipShape(.rect(cornerRadius: 12))
    }
}
