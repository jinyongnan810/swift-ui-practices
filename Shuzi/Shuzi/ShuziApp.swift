//
//  ShuziApp.swift
//  Shuzi
//
//  Created by Yuunan kin on 2025/01/31.
//

import SwiftUI

@main
struct ShuziApp: App {
    @State private var viewModel: GameViewModel = .init()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(viewModel)
        }
    }
}
