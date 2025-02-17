//
//  AlarmApp.swift
//  Alarm
//
//  Created by Yuunan kin on 2025/02/12.
//

import SwiftUI

@main
struct AlarmApp: App {
    var body: some Scene {
        WindowGroup {
            SplashScreenView()
                .environment(\.font, .customFont)
        }
    }
}

