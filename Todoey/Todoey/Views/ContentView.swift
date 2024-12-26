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

    @State var items: [Item] = [
        Item(text: "item1"),
        Item(text: "item2"),
        Item(text: "item3"),
    ]

    @State private var multiSelection = Set<UUID>()
    @State private var showAlert = false
    @State private var newItem = ""

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
                    items.append(Item(text: newItem))
                    newItem = ""
                })
                Button("Cancel", role: .cancel, action: {})
            }
        }
    }
}

#Preview {
    ContentView()
}

struct Item: Identifiable {
    let id = UUID()
    let text: String
}
