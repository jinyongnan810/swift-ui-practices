//
//  DateTextExample.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2025/01/20.
//

import SwiftUI

struct DateTextExample: View {
    let futureDate = Date(timeIntervalSinceNow: 15)
    let dateInterval = DateInterval(start: Date(), end: Date(timeIntervalSinceNow: 300))
    var body: some View {
        List {
            Section("Intervals") {
                Text("Time duration: \(Date.now...Date.now.addingTimeInterval(120))")
                Text("Date interval: \(dateInterval)")
            }
            Section("Time offset") {
                Text("Event will occur in \(futureDate, style: .relative)")
                Text("Event will occur in \(futureDate, style: .offset)")
                Text("Event will occur in \(futureDate, style: .timer)")
            }

            Section("Format Date") {
                Text(Date(), format: .dateTime)
                Text(
                    Date(),
                    format: .dateTime.hour().minute().second().year().month()
                )
            }


        }
    }
}

#Preview {
    DateTextExample()
}
