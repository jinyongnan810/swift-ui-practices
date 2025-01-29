//
//  CalculatorApp.swift
//  Calculator
//
//  Created by Yuunan kin on 2025/01/27.
//

import SwiftUI

@main
struct CalculatorApp: App {
    @AppStorage("darkMode") private var darkMode: Bool = false

    var body: some Scene {
        WindowGroup {
            CalculatorView(darkMode: $darkMode)
                .environment(\.colorScheme, darkMode ? .dark : .light)
        }
    }
}
