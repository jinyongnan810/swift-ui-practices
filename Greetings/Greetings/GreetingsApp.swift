//
//  GreetingsApp.swift
//  Greetings
//
//  Created by Yuunan kin on 2025/01/09.
//

import SwiftUI

@main
struct GreetingsApp: App {
    @AppStorage("language") var language: String?
    var body: some Scene {
        WindowGroup {
            MainView(language: $language)
                .environment(\.locale, language == nil ? .current : Locale(identifier: language!))
        }
    }
}
