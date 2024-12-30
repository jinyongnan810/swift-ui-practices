//
//  ContentView.swift
//  Todoey
//
//  Created by Yuunan kin on 2024/12/23.
//

import CoreData
import SwiftUI

struct ContentView: View {
    init() {
    }

    @Environment(\.scenePhase) private var scenePhase

    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: TodoListView("Some Category")) {
                    Text("Todo List")
                }
            }.navigationTitle("Todoey")
                .navigationBarTitleDisplayMode(.automatic)
                .toolbarBackground(.clear, for: .automatic)
        }.onAppear {
            print("App appeared")
        }
        .onChange(of: scenePhase) { _, newPhase in
            switch newPhase {
                case .active:
                    print("App is active")
                case .inactive:
                    print("App is inactive")
                case .background:
                    print("App is in background")
                @unknown default:
                    print("Unexpected phase.")
            }
        }
    }
}

#Preview {
    ContentView()
        .environment(
            \.managedObjectContext,
            PersistenceController.shared.container.viewContext
        )
}
