//
//  ActivityItem.swift
//  ActivityTracker
//
//  Created by Yuunan kin on 2025/02/05.
//

import SwiftUI

struct ActivityItem: View {
    let activity: Activity
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(activity.name).font(.title)
                Text("\(activity.hoursPerDay.formatted()) hours/day")
            }
            Spacer()
        }
    }
}

#Preview {
    ActivityItem(activity: .init(name: "Coding", hoursPerDay: 6.2))
}
