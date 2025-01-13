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

    @Binding var language: String?

    var body: some View {
        // Portait mode(for iPhone)
        if isPortraitPhone || isIPad {
            NavigationStack {
                GreetingsView()
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            LanguageOptionView(language: $language)
                        }
                    }
            }
        }
        // Landscape mode
        else {
            NavigationStack {
                LandscapeGreetingsView()
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            LanguageOptionView(language: $language)
                        }
                    }
            }
        }
    }
}

#Preview {
    MainView(language: .constant("en"))
}
