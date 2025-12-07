//
//  SwipeActionsPractice.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2025/04/01.
//

import SwiftUI

struct TestDataItem: Identifiable, Hashable {
    var id: UUID = .init()
    var title: String
    var description: String
    var marked: Bool = false
    mutating func toggleMarked() {
        marked.toggle()
    }
}

struct SwipeActionsPractice: View {
    @State private var data: [TestDataItem] = [
        .init(title: "Test 1", description: "Description 1"),
        .init(title: "Test 2", description: "Description 2"),
        .init(title: "Test 3", description: "Description 3"),
        .init(title: "Test 4", description: "Description 4"),
        .init(title: "Test 5", description: "Description 5"),
    ]
    @State private var selections = Set<TestDataItem>()
    @Environment(\.editMode) private var editMode
    var body: some View {
        List(data, selection: $selections) { item in
            HStack {
                VStack(alignment: .leading) {
                    Text(item.title)
                        .font(.headline)
                    Text(item.description)
                        .foregroundColor(.secondary)
                }
                Spacer()
                if item.marked {
                    Image(systemName: "star.fill")
                        .foregroundColor(.green)
                }
            }
            .tag(item)
            .swipeActions {
                Button(
                    "delete",
                    systemImage: "trash",
                    role: .destructive
                ) {
                    withAnimation {
                        data.removeAll { d in
                            d.id == item.id
                        }
                    }
                }
                Button(
                    "star",
                    systemImage: "star"
                ) {
                    withAnimation {
                        if let index = data.firstIndex(where: { d in
                            d.id == item.id
                        }) {
                            data[index].toggleMarked()
                        }
                    }
                }
                .tint(item.marked ? .green : .secondary)
            }
//                .selectionDisabled(true)
        }
        .navigationTitle("Swipe Actions Practice")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing, content: {
                EditButton()
            })
            if !selections.isEmpty {
                ToolbarItem(placement: .bottomBar) {
                    Button(action: {
                        withAnimation {
                            for selection in selections {
                                if let index = data.firstIndex(of: selection) {
                                    data.remove(at: index)
                                }
                            }
                            editMode?.wrappedValue = .inactive
                        }
                    }) {
                        Text("Delete \(selections.count) items")
                            .foregroundStyle(.red)
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        SwipeActionsPractice()
    }
}
