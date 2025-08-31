//
//  DigitalClock.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2025/08/31.
//

import SwiftUI

struct DigitalClock: View {
    var body: some View {
        TimelineView(.periodic(from: .now, by: 1)) { timeline in
            let time = timeline.date
            Text(time.formatted(date: .omitted, time: .standard))
                .font(.system(size: 40, weight: .bold, design: .monospaced))
        }
    }
}

#Preview {
    DigitalClock()
}
