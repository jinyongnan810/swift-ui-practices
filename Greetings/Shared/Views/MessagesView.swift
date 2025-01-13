//
//  MessagesView.swift
//  Greetings
//
//  Created by Yuunan kin on 2025/01/10.
//

import SwiftUI

struct MessagesView: View {
    let messages: [MessageItemModel] = [
        .init(text: "Hello World", color: .myCyan),
        .init(text: "SwiftUI Rocks!!!!!!!!!!!!!!!!", color: .myRed),
        .init(text: "Are you there?", color: .myYellow),
        .init(text: "Start coding now.", color: .myGreen),
        .init(text: "Boom.", color: .myPurple),
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
