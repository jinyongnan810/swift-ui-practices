//
//  TodoItemView.swift
//  Todoey
//
//  Created by Yuunan kin on 2024/12/26.
//

import SwiftUI

struct TodoItemView: View {
    @ObservedObject var item: TodoItem

    var body: some View {
        HStack {
            Text(item.title ?? "")
                .foregroundStyle(Color.black)
            Spacer()
            if item.done {
                Image(systemName: "checkmark")
            }
        }
        .contentShape(Rectangle()) // this make entire area including Spacer() tappable
    }
}

// #Preview {
//    TodoItemView(item: TodoItem(id: UUID(), title: "test", done: false))
// }
