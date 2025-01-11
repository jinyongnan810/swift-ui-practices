//
//  MessagesView.swift
//  Greetings
//
//  Created by Yuunan kin on 2025/01/10.
//

import SwiftUI

struct MessagesView: View {
    let messages: [MessageItemModel] = [
        .init(text: "Hello World", color: .cyan),
        .init(text: "SwiftUI Rocks!!!!!!!!!!!!!!!!", color: .red),
        .init(text: "Are you there?", color: .yellow),
        .init(text: "Start coding now.", color: .green),
        .init(text: "Boom.", color: .purple),
    ]
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(messages) { message in
                MessageView(text: message.text, color: message.color)
            }
        }
    }
}

#Preview {
    MessagesView()
}
