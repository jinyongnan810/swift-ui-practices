//
//  ContentView.swift
//  Greetings
//
//  Created by Yuunan kin on 2025/01/09.
//

import SwiftUI

struct ContentView: View {
    let messages: [MessageItemModel] = [
        .init(text: "Hello World", color: .cyan),
        .init(text: "SwiftUI Rocks!!!!!", color: .red),
        .init(text: "Are you there?", color: .yellow),
        .init(text: "Start coding now.", color: .green),
        .init(text: "Boom.", color: .purple),
    ]
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [.blue, .cyan]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
                .ignoresSafeArea()

            VStack(alignment: .leading) {
                ForEach(messages) { message in
                    MessageView(text: message.text, color: message.color)
                }
            }.padding()

        }
    }
}

#Preview {
    ContentView()
}

