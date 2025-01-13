//
//  ContentView.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2025/01/13.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            List {
                NavigationLink("Navigation Example", destination: NameAndAgeInputView())

            }.navigationTitle("SwiftUI Practices")
        }
    }
}

#Preview {
    ContentView()
}
