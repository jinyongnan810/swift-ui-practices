//
//  GreetingsTextView.swift
//  Greetings
//
//  Created by Yuunan kin on 2025/01/12.
//

import SwiftUI

struct GreetingsTextView: View {
    @Binding var subtitle: LocalizedStringKey

    let subtitles: [LocalizedStringKey] = [
        "Explore SwiftUI",
        "SwiftUI is a powerful tool for building user interfaces.",
        "SwiftUI is designed to be flexible and adaptable.",
        "SwiftUI is designed to be efficient and performant."
    ]

    var body: some View {
        VStack(alignment: .leading) {
            Text("Greetings")
                .font(.largeTitle)
                .fontWeight(.semibold)
            Text(subtitle)
                .font(.headline)
                .fontWeight(.light)
        }
        .onTapGesture {
            withAnimation(.spring()) {
                subtitle = subtitles
                    .randomElement() ?? LocalizedStringKey("Explore SwiftUI")
            }
        }
    }
}

#Preview {
    GreetingsTextView(subtitle: .constant("Explore SwiftUI"))
}
