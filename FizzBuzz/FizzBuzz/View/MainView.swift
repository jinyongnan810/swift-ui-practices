//
//  MainView.swift
//  FizzBuzz
//
//  Created by Yuunan kin on 2025/02/02.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            Tab("FizzBuzz", systemImage: "bubbles.and.sparkles") {
                FizzBuzzView()
            }
            Tab("Generator", systemImage: "note.text") {
                CodeGeneratorView()
            }
            Tab("About", systemImage: "info.bubble.fill") {
                AboutView()
            }
        }
    }
}

#Preview {
    MainView()
}
