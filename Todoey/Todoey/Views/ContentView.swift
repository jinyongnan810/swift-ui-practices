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

    @State var items: [Item] = []

    @State private var multiSelection = Set<String>()
    @State private var showAlert = false
    @State private var newItem = ""

    @Environment(\.scenePhase) private var scenePhase

    var body: some View {
        NavigationView {
//            List {
//                ForEach(items) { item in
//                    /*@START_MENU_TOKEN@*/Text(item.text)/*@END_MENU_TOKEN@*/
//                }.onDelete { index in
//
//                }.onMove { source, destination in
//
//                }
//            }
            List(items, selection: $multiSelection) { item in
                TodoItem(item: item)
            }
            .navigationTitle("Todoey")
            .toolbar {
                HStack {
                    EditButton().foregroundStyle(.white)
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
                    items.append(Item(id: UUID().uuidString ,text: newItem))
                    if let encoded = try? JSONEncoder().encode(items) {
                        UserDefaults.standard.set(encoded, forKey: "items")
                    }
                    newItem = ""
                })
                Button("Cancel", role: .cancel, action: {})
            }
            .onAppear() {
                print("App appeared")
                if let encoded = UserDefaults.standard.data(forKey: "items") {
                    items = try! JSONDecoder().decode([Item].self, from: encoded)
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

struct Item: Identifiable, Codable {
    let id: String
    let text: String
}
