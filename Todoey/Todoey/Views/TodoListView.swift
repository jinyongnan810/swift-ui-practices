//
//  TodoListView.swift
//  Todoey
//
//  Created by Yuunan kin on 2024/12/30.
//

import SwiftUI

struct TodoListView: View {
    let category: TodoCategory

    @Environment(\.managedObjectContext) private var viewContext
    var todoItemFetchRequest: FetchRequest<TodoItem>
    private var items: FetchedResults<TodoItem> { todoItemFetchRequest.wrappedValue }

    init(_ category: TodoCategory) {
        self.category = category
        todoItemFetchRequest = FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \TodoItem.createdAt, ascending: false)],
                                            predicate: NSPredicate(format: "category == %@", category),
                                            animation: .default)
    }

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
        newItem.category = category
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
            .navigationTitle(category.name!)
            .navigationBarItems(trailing: Button(action: {
                showAlert = true
            }) {
                Image(systemName: "plus")
            })
            .alert("Add new todo item", isPresented: $showAlert) {
                TextField("New item", text: $newItem)
                Button("Add", action: {
                    add(newItem)
                    newItem = ""
                })
                Button("Cancel", role: .cancel, action: {})
            }
        }
        .searchable(text: $searchText, prompt: "Search todos in \(category.name!)")
        .onSubmit(of: .search) {
            print("⭐️searched")
        }
    }
}
