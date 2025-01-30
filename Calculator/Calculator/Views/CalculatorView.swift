//
//  CalculatorView.swift
//  Calculator
//
//  Created by Yuunan kin on 2025/01/27.
//

import SwiftUI

// original design by: https://dribbble.com/shots/14709020-Calculator

struct CalculatorView: View {
    @Binding var darkMode: Bool
    @State var computation: String = ""
    @State var result: String = "0"
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            VStack {
                LightModeSwicherView(darkMode: $darkMode)
                Spacer()
                InputAndResultView(computation: computation, result: result)
                ButtonsView(computation: $computation, result: $result)
            }
        }
    }
}

#Preview {
    CalculatorView(darkMode: .constant(false))
}
