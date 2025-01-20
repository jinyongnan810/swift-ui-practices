//
//  MarkdownExample.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2025/01/20.
//

import SwiftUI

struct MarkdownExample: View {
    let markdownText: String = """
        ***Hello Markdown***
        ~~Strike Through~~
        - [Apple](https://apple.com): Checkout Apple website.
        - [Udemy](https://udemy.com): Checkout Udemy.
    """

    let gradient = LinearGradient(
        colors: [.red, .yellow, .green, .blue, .purple],
        startPoint: .leading,
        endPoint: .trailing
    )

    var welcomeText: Text {
        Text("*Welcome*").foregroundStyle(gradient)
    }

    @State private var openedUrlTimes: Int = 0

    @State private var showingAlert: Bool = false

    var body: some View {
        ScrollView {
            VStack {
                Text("""
                    ***Hello Markdown***
                    ~~Strike Through~~
                    - **[Apple](https://apple.com)**: Checkout Apple website.
                    - [Udemy](https://udemy.com): Checkout Udemy.
                """).tint(.red).foregroundStyle(.cyan).padding()

                Divider()

                Text(markdownText).font(.caption).foregroundColor(.gray)

                Divider()

                Text(LocalizedStringKey(markdownText)).tint(.red).foregroundStyle(.cyan).padding()

                Divider()

                Text("\(welcomeText) to **SwiftUI**!")

                Divider()

                VStack {
                    Text("**[Apple](https://apple.com)**: Checkout Apple website \(openedUrlTimes) times.")
                        .environment(\.openURL, OpenURLAction { _ in
                            openedUrlTimes += 1
                            return .systemAction
                        })
                    Text("**[Blocked Site](https://some-blocked-site.com)**: this site is blocked.")
                        .environment(\.openURL, OpenURLAction { _ in
                            showingAlert = true
                            return .handled
                        })
                }
            }
        }.alert("Blocked Site", isPresented: $showingAlert) {
            VStack {
                Text("This site is blocked.")
                Button("OK", role: .cancel) {}
            }
        }
    }
}

#Preview {
    MarkdownExample()
}
