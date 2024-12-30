//
//  TodoListView.swift
//  Todoey
//
//  Created by Yuunan kin on 2024/12/30.
//

import SwiftUI

struct TodoListView: View {
    init(_ category: String) {
        self.category = category
    }

    let category: String


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
            .navigationTitle(category)
            .navigationBarItems( trailing: Button(action: {
                showAlert = true
            }) {
                Image(systemName: "plus")
            })
            .alert("Add new todo item", isPresented: $showAlert) {
                TextField("New item", text: $newItem)
                Button("Add", action: {
                    print("Add tapped")
                    add(newItem)
                    newItem = ""
                })
                Button("Cancel", role: .cancel, action: {})
            }
        }
        .searchable(text: $searchText, prompt: "Search todos")
        .onSubmit(of: .search) {
            print("⭐️searched")
        }
    }

}

#Preview {
    TodoListView("Some Category")
}
