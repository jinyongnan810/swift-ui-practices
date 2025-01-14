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
                NavigationLink("Navigation", destination: NameAndAgeInputView())
                NavigationLink("View Modifier", destination: CustomViewModifierExample())
                NavigationLink("Mesh Gradient & Timer & Animation", destination: MeshGradientExample())
            }.navigationTitle("SwiftUI Practices")
        }
    }
}

#Preview {
    ContentView()
}
