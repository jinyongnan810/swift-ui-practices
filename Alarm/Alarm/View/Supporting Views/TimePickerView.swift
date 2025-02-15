//
//  TimePickerView.swift
//  Alarm
//
//  Created by Yuunan kin on 2025/02/15.
//

import SwiftUI

struct TimePickerView: View {
    @Binding var time: Date
    var scale: CGFloat = 1
    var body: some View {
        DatePicker("", selection: $time, displayedComponents: .hourAndMinute)
            .labelsHidden()
            .scaleEffect(scale)
    }
}

#Preview {
    TimePickerView(time: .constant(Date()), scale: 1.6)
}
