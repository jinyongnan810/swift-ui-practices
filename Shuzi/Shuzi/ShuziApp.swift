//
//  ShuziApp.swift
//  Shuzi
//
//  Created by Yuunan kin on 2025/01/31.
//

import SwiftUI

@main
struct ShuziApp: App {
    @State private var gameViewModel: GameViewModel = .init()
    @State private var proverbViewModel: ProverbViewModel = .init()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(gameViewModel)
                .environment(proverbViewModel)
        }
    }
}
