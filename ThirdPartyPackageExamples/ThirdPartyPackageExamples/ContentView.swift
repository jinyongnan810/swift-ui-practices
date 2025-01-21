//
//  ContentView.swift
//  ThirdPartyPackageExamples
//
//  Created by Yuunan kin on 2025/01/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            List {
                NavigationLink("Lottie") {
                    LottieExample()
                }
            }.navigationTitle("Third Party Package Examples")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ContentView()
}
