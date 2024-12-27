//
//  TodoeyApp.swift
//  Todoey
//
//  Created by Yuunan kin on 2024/12/23.
//

import SwiftUI

@main
struct TodoeyApp: App {
    let persistenceController = PersistenceController.shared
    var body: some Scene {
        WindowGroup {
            ContentView()
        }.environment(\.managedObjectContext, persistenceController.container.viewContext)
    }
}
