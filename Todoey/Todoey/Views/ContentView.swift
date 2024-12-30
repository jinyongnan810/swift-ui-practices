//
//  ContentView.swift
//  Todoey
//
//  Created by Yuunan kin on 2024/12/23.
//

import CoreData
import SwiftUI

struct ContentView: View {
    init() {}

    @Environment(\.scenePhase) private var scenePhase

    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [],
        animation: .default
    )
    private var items: FetchedResults<TodoCategory>

    @State private var showAlert = false
    @State private var newItem = ""

    @State private var searchText: String = ""
    private var searchedItems: [TodoCategory] {
        guard !searchText.isEmpty else { return Array(items) }
        return items.filter { $0.name?.contains(searchText) == true }
    }

    func save() {
        print("⭐️saving categories")
        withAnimation {
            if viewContext.hasChanges {
                do {
                    try viewContext.save()
                } catch {
                    let nsError = error as NSError
                    print("⭐️save error \(nsError), \(nsError.userInfo)")
                }
            } else {
                print("⭐️no changes")
            }
        }
        print("⭐️saved")
    }

    func add(_ text: String) {
        let newItem = TodoCategory(context: viewContext)
        newItem.name = text
        newItem.id = UUID()
        save()
    }

    func deleteItemAt(_ index: Int) {
        if items.indices.contains(index) {
            let item = items[index]
            viewContext.delete(item)
            save()
        }
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(searchedItems) { item in
                    NavigationLink(destination: TodoListView(item)) {
                        Text(item.name!)
                    }
                }

            }.navigationTitle("Todoey")
                .navigationBarTitleDisplayMode(.automatic)
                .navigationBarItems(trailing: Button(action: {
                    showAlert = true
                }) {
                    Image(systemName: "plus")
                })
                .alert("Add new category", isPresented: $showAlert) {
                    TextField("New item", text: $newItem)
                    Button("Add", action: {
                        add(newItem)
                        newItem = ""
                    })
                    Button("Cancel", role: .cancel, action: {})
                }
        }
        .searchable(text: $searchText, prompt: "Search Categories")
        .onSubmit(of: .search) {
            print("⭐️searched")
        }
        .onAppear {
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
