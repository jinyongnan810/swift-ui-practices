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
    @State var customization = TabViewCustomization()
    var body: some View {
        TabView(selection: $selectedTab) {
            Tab("Movies", systemImage: "play", value: .movies) {
                Text("Movie list")
            }
            .customizationID("com.myApp.Movies")
            Tab("Books", systemImage: "book.pages.fill", value: .books) {
                Text("Book list")
            }
            .customizationID("com.myApp.Books")
            Tab(value: .search, role: .search) {
                Text("Search movies or books")
            }
            .customizationID("com.myApp.Search")
            // currently it seems like selection and TabSection is not compatable
//            TabSection("Hobbies") {
//                Tab("Tab 1", systemImage: "person", value: .music) {
//                    Text("Tab 1 View")
//                }
//                Tab("Tab 2", systemImage: "trash", value: .meditation) {
//                    Text("Tab 2 View")
//                }
//            }
        }
        .tabViewStyle(.sidebarAdaptable)
        .tabViewCustomization($customization)
        .onChange(of: selectedTab) { previous, next in
            print("⭐️ selectedTab changed from \(previous) to \(next)")
        }
    }
}

#Preview {
    TabViewExample()
}
