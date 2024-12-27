//
//  TodoItem.swift
//  Todoey
//
//  Created by Yuunan kin on 2024/12/26.
//

import SwiftUI

struct TodoItemView: View {
    let item: TodoItem

    var body: some View {
        HStack {
            Text(item.title)
                .foregroundStyle(Color.black)
            Spacer()
            if item.done {
                Image(systemName: "checkmark")
            }
        }
        .contentShape(Rectangle()) // this make entire area including Spacer() tappable
    }
}

#Preview {
    TodoItemView(item: TodoItem(id: "1", title: "test", done: false))
}
