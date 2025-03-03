//
//  ActivityListView.swift
//  BodyShape
//
//  Created by Yuunan kin on 2025/03/03.
//

import SwiftUI

enum ActivityType: String, CaseIterable {
    case running = "Running"
    case biking = "Biking"
    case climbing = "Climbing"
    case skating = "Skating"
}

extension ActivityType {
    var systemName: String {
        switch self {
        case .running:
            "figure.run"
        case .biking:
            "figure.outdoor.cycle"
        case .climbing:
            "figure.climbing"
        case .skating:
            "figure.skating"
        }
    }
}

struct ActivityListView: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(ActivityType.allCases, id: \.self) { activityType in
                    VStack(alignment: .leading) {
                        Image(systemName: activityType.systemName)
                            .imageScale(.large)
                            .padding()
                            .background(Circle().fill(.lightPurple))
                        Text(activityType.rawValue)
                            .font(.title)
                            .fontWeight(.semibold)
                    }
                    .frame(width: 120)
                    .toCard(hasBorder: true)
                }
            }
        }
    }
}

#Preview {
    ActivityListView()
}
