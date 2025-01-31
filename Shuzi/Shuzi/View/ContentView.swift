//
//  ContentView.swift
//  Shuzi
//
//  Created by Yuunan kin on 2025/01/31.
//

import SwiftUI

struct ContentView: View {
    @State private var viewModel: GameViewModel = .init()

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
                .onTapGesture {
                    viewModel.speak(text: "二十二")
                }
        }
        .padding()
    }
    
}

#Preview {
    ContentView()
}
