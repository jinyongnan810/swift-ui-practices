//
//  TodoItem.swift
//  Todoey
//
//  Created by Yuunan kin on 2024/12/26.
//

import SwiftUI

struct TodoItem: View {
    let item: Item

    var body: some View {
        HStack {
            Text(item.text)
                .foregroundStyle(Color.black)
            Spacer()
        }
    }
}

#Preview {
    TodoItem(item: Item(id: "1", text: "test"))
}
