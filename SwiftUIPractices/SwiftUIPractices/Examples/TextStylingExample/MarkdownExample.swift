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
    var body: some View {
        VStack {
            Text("""
                ***Hello Markdown***
                ~~Strike Through~~
                - [Apple](https://apple.com): Checkout Apple website.
                - [Udemy](https://udemy.com): Checkout Udemy.
            """).tint(.red).foregroundStyle(.cyan).padding()

            Divider()

            Text(markdownText).font(.caption).foregroundColor(.gray)

            Divider()

            Text(LocalizedStringKey(markdownText)).tint(.red).foregroundStyle(.cyan).padding()
        }
    }
}

#Preview {
    MarkdownExample()
}
