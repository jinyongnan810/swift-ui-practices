//
//  TabViewExample.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2025/01/15.
//

import SwiftUI

enum TabType {
    case movies, books, music, meditation, search
}

struct TabViewExample: View {
    @State private var selectedTab: TabType = .movies
    var body: some View {
        TabView(selection: $selectedTab) {
            Tab("Movies", systemImage: "play", value: .movies) {
                Text("Movie list")
            }
            Tab("Books", systemImage: "book.pages.fill", value: .books) {
                Text("Book list")
            }
            Tab(value: .search, role: .search) {
                Text("Search movies or books")
            }
        }
        .tabViewStyle(.sidebarAdaptable)
        .onChange(of: selectedTab) { previous, next in
            print("⭐️ selectedTab changed from \(previous) to \(next)")
        }
    }
}

#Preview {
    TabViewExample()
}
