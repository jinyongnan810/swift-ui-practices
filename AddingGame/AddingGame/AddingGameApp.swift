//
//  AddingGameApp.swift
//  AddingGame
//
//  Created by Yuunan kin on 2025/02/10.
//

import SwiftData
import SwiftUI

@main
struct AddingGameApp: App {
    let container: ModelContainer
    init() {
        do {
            container = try ModelContainer(for: HighScoreModel.self)
        } catch {
            fatalError("Unable to create ModelContainer: \(error)")
        }
    }

    var body: some Scene {
        WindowGroup {
            MainView(context: container.mainContext)
                .modelContainer(container)
        }
    }
}
