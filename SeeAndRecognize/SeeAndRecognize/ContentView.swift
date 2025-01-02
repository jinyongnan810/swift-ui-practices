//
//  ContentView.swift
//  SeeAndRecognize
//
//  Created by Yuunan kin on 2025/01/02.
//

import SwiftUI

struct ContentView: View {
    @State private var isShowingCamera = false
    @State private var image: Image? = nil
    @State private var description: String = "Take a photo"

    var body: some View {
        NavigationView {
            List {
                image?
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                Text(description)
            }
            .navigationTitle("See and Recognize")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Take Photo") {
                        isShowingCamera = true
                    }
                    .sheet(isPresented: $isShowingCamera) {
                        CameraView(isShown: $isShowingCamera, image: $image,
                                   result: $description)
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
