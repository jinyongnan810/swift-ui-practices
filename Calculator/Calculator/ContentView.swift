//
//  ContentView.swift
//  Calculator
//
//  Created by Yuunan kin on 2025/01/27.
//

import SwiftUI

// original design by: https://dribbble.com/shots/14709020-Calculator

struct ContentView: View {
    @Binding var darkMode: Bool
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            VStack {
                LightModeSwicherView(darkMode: $darkMode)
                InputAndResultView()
                ButtonsView()
            }
        }
    }
}

#Preview {
    ContentView(darkMode: .constant(false))
}
