//
//  TimeOfDayIcon.swift
//  Alarm
//
//  Created by Yuunan kin on 2025/02/14.
//

import SwiftUI

struct TimeOfDayIcon: View {
    let date: Date
    var percent: CGFloat {
        dateToPercent(date)
    }

    var hour: Int {
        Int(24 * percent)
    }

    var image: (name: String, color: Color) {
        switch hour {
        case 6 ..< 8:
            ("sun.and.horizon.fill", .orange)
        case 8 ..< 17:
            ("sun.max.fill", .yellow)
        case 17 ..< 20:
            ("sun.and.horizon.fill", .pink)
        case 20 ..< 23:
            ("moon.fill", .black)
        default:
            ("moon.stars.fill", .black)
        }
    }

    var body: some View {
        Image(systemName: image.name)
            .imageScale(.large)
            .foregroundStyle(image.color)
    }
}

#Preview {
    List {
        ForEach(0 ..< 24, id: \.self) { i in
            let time = currentDayWithHourSet(i)
            HStack {
                Text("\(getTimeOfDate(time))")
                Spacer()
                TimeOfDayIcon(date: time)
            }
        }
    }
}
