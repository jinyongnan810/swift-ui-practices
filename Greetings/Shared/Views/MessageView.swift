//
//  MessageView.swift
//  Greetings
//
//  Created by Yuunan kin on 2025/01/09.
//

import SwiftUI

struct MessageView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.verticalSizeClass) var verticalSizeClass
    var isIPad: Bool {
        horizontalSizeClass == .regular && verticalSizeClass == .regular
    }

    let text: LocalizedStringKey
    @State var color: Color

    let randomColors: [Color] = [.green, .cyan, .red, .blue, .yellow, .purple, .orange, .pink, .gray, .black]

    var font: Font {
        #if os(macOS)
            .title
        #else
            isIPad ? .largeTitle : .body
        #endif
    }

    var body: some View {
        Text(text)
            .font(font)
            .fontWeight(.semibold)
            .padding()
            .background(color.opacity(0.7))
            .cornerRadius(20)
            .shadow(color: color.opacity(0.5), radius: 5, x: 5, y: 5)
            .onTapGesture {
                guard let newColor = randomColors.randomElement() else { return }
                color = newColor
            }
    }
}

#Preview {
    VStack {
        MessageView(text: "Hello World!", color: .green)
        MessageView(text: "Hello World2!", color: .cyan)
        MessageView(text: "Hello World3!", color: .red)
    }
}
