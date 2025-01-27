//
//  ContentView.swift
//  Calculator
//
//  Created by Yuunan kin on 2025/01/27.
//

import SwiftUI

// original design by: https://dribbble.com/shots/14709020-Calculator

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            VStack {
                LightModeSwicherView()
                InputAndResultView()
                ButtonsView()
            }
        }
    }
}

#Preview {
    ContentView()
}
