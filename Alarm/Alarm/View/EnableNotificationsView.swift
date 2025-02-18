//
//  EnableNotificationsView.swift
//  Alarm
//
//  Created by Yuunan kin on 2025/02/15.
//

import SwiftUI

struct EnableNotificationsView: View {
    @Environment(LocalNotificationManager.self) var localNotificationManager
    var body: some View {
        ZStack {
            FourCircleBackgroundView(color1: .myPurple, color2: .clear)
            VStack {
                Spacer()
                Text("Enable notifications to hear the alarm!")
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                Spacer()
                ButtonView(text: "Enable").padding()
                    .onTapGesture {
                        localNotificationManager.openSettings()
                    }
            }
        }
    }
}

#Preview {
    EnableNotificationsView()
}
