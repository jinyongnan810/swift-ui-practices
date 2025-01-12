//
//  MainView.swift
//  Greetings
//
//  Created by Yuunan kin on 2025/01/12.
//

import SwiftUI

struct MainView: View {
    // https://developer.apple.com/design/human-interface-guidelines/layout#iOS-iPadOS-device-size-classes
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.verticalSizeClass) var verticalSizeClass

    var isPortraitPhone: Bool {
        horizontalSizeClass == .compact && verticalSizeClass == .regular
    }

    var isIPad: Bool {
        horizontalSizeClass == .regular && verticalSizeClass == .regular
    }

    var body: some View {
        // Portait mode(for iPhone)
        if isPortraitPhone || isIPad {
            GreetingsView()
        }
        // Landscape mode
        else {
            LandscapeGreetingsView()
        }
    }
}

#Preview {
    MainView()
}
