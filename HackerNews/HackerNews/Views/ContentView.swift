//
//  ContentView.swift
//  HackerNews
//
//  Created by Yuunan kin on 2024/12/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var networkManager: NetworkManager = .init()

    var body: some View {
        NavigationView {
            List(networkManager.posts) { post in
                NavigationLink(destination: DetailsView(url: post.url)) {
                    HStack {
                        Text("\(post.points)")
                        Text(post.title)
                    }
                }

            }.navigationTitle("Hacker News")
        }.onAppear {
            networkManager.fetchNews()
        }
    }
}

#Preview {
    ContentView()
}
