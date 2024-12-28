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
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.systemBlue
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
    }

    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \TodoItem.createdAt, ascending: false)],
        animation: .default
    )
    private var items: FetchedResults<TodoItem>

    @State private var showAlert = false
    @State private var newItem = ""

    private var searchedItems: [TodoItem] {
        guard !searchText.isEmpty else { return Array(items) }
        return items.filter { $0.title?.contains(searchText) == true }
    }

    @State private var searchText: String = ""

    @Environment(\.scenePhase) private var scenePhase

    func save() {
        print("⭐️saving")
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
        let newItem = TodoItem(context: viewContext)
        newItem.title = text
        newItem.id = UUID()
        newItem.done = false
        newItem.createdAt = Date()
        save()
    }

    func updateDone(_ id: UUID) {
        if let index = items.firstIndex(where: { $0.id == id }) {
            let item = items[index]
            item.done.toggle()
            save()
        }
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
                    TodoItemView(item: item)
                        .onTapGesture {
                            if let id = item.id {
                                updateDone(id)
                            }
                        }
                }.onDelete { indexSet in
                    for index in indexSet {
                        deleteItemAt(index)
                    }
                }
            }
            .navigationTitle("Todoey")
            .navigationBarTitleDisplayMode(.automatic)
            .toolbarBackground(.clear, for: .automatic)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showAlert = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }.alert("Add new todo item", isPresented: $showAlert) {
                TextField("New item", text: $newItem)
                Button("Add", action: {
                    print("Add tapped")
                    add(newItem)
                    newItem = ""
                })
                Button("Cancel", role: .cancel, action: {})
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
        .searchable(text: $searchText, prompt: "Search todos")
    }
}

#Preview {
    ContentView()
        .environment(
            \.managedObjectContext,
            PersistenceController.shared.container.viewContext
        )
}
