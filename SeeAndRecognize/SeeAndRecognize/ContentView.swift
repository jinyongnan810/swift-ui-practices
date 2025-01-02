//
//  ContentView.swift
//  SeeAndRecognize
//
//  Created by Yuunan kin on 2025/01/02.
//

import SwiftUI
import CoreML
import Vision

struct ContentView: View {
    @State private var isShowingCamera = false
    @State private var image: Image? = nil

    var body: some View {
        NavigationView {
            List {
                image?
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
            }
            .navigationTitle("See and Recognize")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Tack Photo") {
                        isShowingCamera = true
                    }
                    .sheet(isPresented: $isShowingCamera) {
                        CameraView(isShown: self.$isShowingCamera, image: self.$image)
                    }
                }
            }

        }

    }
}

#Preview {
    ContentView()
}
