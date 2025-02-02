//
//  FizzBuzzApp.swift
//  FizzBuzz
//
//  Created by Yuunan kin on 2025/02/02.
//

import SwiftUI

@main
struct FizzBuzzApp: App {
    @State private var viewModel = AlgViewModel()
    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(viewModel)
        }
    }
}
