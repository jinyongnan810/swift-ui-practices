//
//  ContentView.swift
//  Todoey
//
//  Created by Yuunan kin on 2024/12/23.
//

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

    @State var items: [TodoItem] = []
//    {
//        didSet { save() }
//    }

    @State private var multiSelection = Set<String>()
    @State private var showAlert = false
    @State private var newItem = ""

    @Environment(\.scenePhase) private var scenePhase

    func save() {
        print("⭐️saveing")
        if let encoded = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encoded, forKey: "items")
        }
        print("⭐️saved")
    }

    var body: some View {
        NavigationView {
            List(items) { item in
                TodoItemView(item: item)
                    .onTapGesture {
                        if let index = items.firstIndex(where: { $0.id == item.id }) {
                            items[index].toggleDone()
                            // currently not supporting detect list item's change
                            save()
                        }

                    }
            }
            .navigationTitle("Todoey")
            .toolbar {
                HStack {
                    Button(
                        action: {
                            print("Add button tapped")
                            showAlert = true
                        }) {
                            Image(systemName: "plus")
                                .foregroundColor(.white)
                        }
                }
            }.alert("Add new todo item", isPresented: $showAlert) {
                TextField("New item", text: $newItem)
                Button("Add", action: {
                    print("Add tapped")
                    items.append(TodoItem(id: UUID().uuidString ,title: newItem, done: false))
                    save()
                    newItem = ""
                })
                Button("Cancel", role: .cancel, action: {})
            }
            .onAppear() {
                print("App appeared")
                if let encoded = UserDefaults.standard.data(forKey: "items") {
                    items = try! JSONDecoder().decode([TodoItem].self, from: encoded)
                }
            }
            .onChange(of: scenePhase) { oldPhase, newPhase in
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
}

#Preview {
    ContentView()
}

